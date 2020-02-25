# frozen_string_literal: true

require "decidim/core"
require "csv"
require "json"
# require "rgeo/geo_json"
require "custom_csv_filter"


namespace :decidim do
  Rails.logger = Logger.new(STDOUT)

  namespace :scopes do
    desc "Import scopes"
    task import: :environment do |task|
      ARGV.each { |a| task a.to_sym do ; end }
      @ROOT = task.application.original_dir
      @TYPES = {}

      if Decidim::Organization.exists?(:host => ARGV[1])
        @organization = Decidim::Organization.find_by(:host => ARGV[1])
      else
        Rails.logger.error "Could not find any organization with host \"#{ARGV[1]}\""
        exit 1
      end

      import_scopes({
        type_name: "Région",
        type_plural: "Régions",
        csv_file: "vendor/bosa/TU_COM_REFNIS.csv",
        csv_filter: {
          "LVL_REFNIS": "1"
        },
        csv_mapping: {
          code: "CD_REFNIS",
          name: {
            "de": "TX_REFNIS_DE",
            "fr": "TX_REFNIS_FR",
            "nl": "TX_REFNIS_NL"
          }
        },
        validation: "DT_VLDT_END"
      })

      import_scopes({
        type_name: "Province",
        type_plural: "Provinces",
        csv_file: "vendor/bosa/TU_COM_REFNIS.csv",
        csv_filter: {
          "LVL_REFNIS": "2"
        },
        csv_mapping: {
          code: "CD_REFNIS",
          parent: "CD_SUP_REFNIS",
          name: {
            "de": "TX_REFNIS_DE",
            "fr": "TX_REFNIS_FR",
            "nl": "TX_REFNIS_NL"
          }
        },
        validation: "DT_VLDT_END"
      })

      import_scopes({
        type_name: "Arrondissement",
        type_plural: "Arrondissements",
        csv_file: "vendor/bosa/TU_COM_REFNIS.csv",
        csv_filter: {
          "LVL_REFNIS": "3"
        },
        csv_mapping: {
          code: "CD_REFNIS",
          parent: "CD_SUP_REFNIS",
          name: {
            "de": "TX_REFNIS_DE",
            "fr": "TX_REFNIS_FR",
            "nl": "TX_REFNIS_NL"
          }
        },
        validation: "DT_VLDT_END"
      })

      import_scopes({
        type_name: "Commune",
        type_plural: "Communes",
        csv_file: "vendor/bosa/TU_COM_REFNIS.csv",
        csv_filter: {
          "LVL_REFNIS": "4"
        },
        csv_mapping: {
          code: "CD_REFNIS",
          parent: "CD_SUP_REFNIS",
          name: {
            "de": "TX_REFNIS_DE",
            "fr": "TX_REFNIS_FR",
            "nl": "TX_REFNIS_NL"
          }
        },
        validation: "DT_VLDT_END"
      })

      Rails.logger.close
      exit
    end

    namespace :generate do
      desc "Generate assemblies from scopes"
      task assemblies: :environment do |task|
        ARGV.each { |a| task a.to_sym do ; end }

        if Decidim::Organization.exists?(:host => ARGV[1])
          @organization = Decidim::Organization.find_by(:host => ARGV[1])
        else
          Rails.logger.error "Could not find any organization with host \"#{ARGV[1]}\""
          exit 1
        end

        generate_assemblies

      end
    end
  end
end


def path_for(path)
  if path.start_with?("/")
    path
  else
    @ROOT + "/" + path
  end
end

def check_file(path, ext = nil)
  check = true

  if path.blank?
    Rails.logger.error "File path is blank"
    check = false
  end

  unless File.exist?(path_for(path))
    Rails.logger.error "File does not exist or is unreachable"
    check = false
  end

  if ext.present? && File.extname(path) != ".#{ext.to_s}"
    Rails.logger.error "File extension does not match \"#{ext.to_s}\""
    check = false
  end

  return check
end

def parse_validation_date(validation_date)
  if validation_date.match(/^(((0)[0-9])|((1)[0-2]))(\/)([0-2][0-9]|(3)[0-1])(\/)\d{4}$/i) # mm/dd/yyyy
    Date.strptime(validation_date, '%m/%d/%Y')
  elsif validation_date.match(/^(((0)[0-9])|((1)[0-2]))(\/)([0-2][0-9]|(3)[0-1])(\/)\d{2}$/i) # mm/dd/yyyy
    Date.strptime(validation_date, '%m/%d/%y')
  elsif validation_date.match(/^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$/i) # dd/mm/yyyy
    Date.strptime(validation_date, '%d/%m/%Y')
  elsif validation_date.match(/^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{2}$/i) # dd/mm/yy
    Date.strptime(validation_date, '%d/%m/%y')
  elsif validation_date.is_a?(Date)
    validation_date
  else
    Time.zone.now.to_date
  end
end

def check_csv_filter(options, row)
  result = true
  options[:csv_filter].each do |key,value|
    if row.include?(key.to_s)
      Rails.logger.info "CSV filter for #{key} == #{value} with #{row[key.to_s]}"
      result &&= ( row[key.to_s] == value )
    end
  end
  if options[:validation].present? && validation_date = parse_validation_date(row[options[:validation]])
    Rails.logger.info "CSV filter validation date #{options[:validation]} with #{validation_date}"
    result &&= ( validation_date >= Time.zone.now.to_date )
  end
  result
end

def import_scopes(params)
  @options = {
    host: params.dig(:host),
    type_name: params.dig(:type_name),
    type_plural: params.dig(:type_plural) || params.dig(:type_name),
    csv_file: params.dig(:csv_file),
    csv_filter: params.dig(:csv_filter) || {},
    csv_mapping: params.dig(:csv_mapping),
    validation: params.dig(:validation),
    geojson_file: params.dig(:geojson_file),
    geojson_color: params.dig(:geojson_color) || "#ef604d"
  }

  Rails.logger.info @options

  if check_file(@options[:csv_file], :csv)
    @csv = CSV.read(path_for(@options[:csv_file]), col_sep: ',', headers: true, skip_blanks: true, converters: %i[date])
  else
    Rails.logger.error "Could not load CSV file \"#{@options[:csv_file]}\""
    exit 1
  end

  if @options[:geojson_file].present?
    if check_file(@options[:geojson_file], :geojson)
      @geojson = JSON.parse(File.read(path_for(@options[:geojson_file])))
    else
      Rails.logger.error "Could not load GeoJSON file \"#{@options[:geojson_file]}\""
      exit 1
    end
  end

  @scope_type = Decidim::ScopeType.where(decidim_organization_id: @organization.id)
  .where('name @> ?', {"#{@organization.default_locale}": @options[:type_name]}.to_json)
  .first_or_create!(
    name: {"#{@organization.default_locale}": @options[:type_name]},
    plural: {"#{@organization.default_locale}": @options[:type_plural]}
  )

  if @options[:csv_mapping].dig(:code)

    @csv.each do |row|

      if check_csv_filter(@options, row)
        # Rails.logger.info row.to_h
        _code = row[@options[:csv_mapping].dig(:code)]
        _name = @options[:csv_mapping].dig(:name).map { |k,v| [k, row[v]] }.to_h

        _parent = @options[:csv_mapping].dig(:parent) ? Decidim::Scope.find_by(
          :decidim_organization_id => @organization.id,
          :code => row[@options[:csv_mapping].dig(:parent)]
        )&.id : nil

        Rails.logger.debug _parent

        scope = Decidim::Scope.find_or_initialize_by(
          decidim_organization_id: @organization.id,
          scope_type_id: @scope_type.id,
          code: _code
        ).update!(
          code: _code,
          parent_id: _parent,
          name: _name,
        )
      end
    end
  end

  if @options[:geojson_file].present? && @geojson.dig("features")
    @geojson.dig("features").each do |feature|
      Rails.logger.info feature.dig("type")
      Rails.logger.info feature.dig("properties")

      if feature.dig("type") == "Feature"
        Decidim::Scope.find_by(
          decidim_organization_id: @organization.id,
          scope_type_id: @scope_type.id,
          code: @options[:csv_mapping].dig(:code) + "-" + feature.dig("properties", "code")
        ).update!(
          geojson: {
            color: @options[:geojson_color],
            geometry: feature.to_json,
            parsed_geometry: feature
          }
        )
      end
    end
  end
end

def generate_assemblies
  Decidim::Scope.where(
    decidim_organization_id: @organization.id,
    parent_id: nil
  ).each do |scope|

    parent_assembly = Decidim::Assembly.find_or_create_by!(
      organization: @organization,
      title: scope.name,
      slug: scope.code,
      subtitle: scope.name,
      short_description: "<p>#{scope.name[@organization.default_locale]}</p>",
      description: "<p>#{scope.name[@organization.default_locale]}</p>",
      scope: scope
    )

    parent_assembly.update!(
      hashtag: "##{scope.name[@organization.default_locale].camelize}",
      # hero_image: File.new(File.join(seeds_root, "city.jpeg")),
      # banner_image: File.new(File.join(seeds_root, "city2.jpeg")),
      promoted: true,
      published_at: 2.weeks.ago,
      meta_scope: scope.name
    )

    Decidim::Scope.where(
      decidim_organization_id: @organization.id,
      parent_id: scope.id
    ).each do |child_scope|

      Rails.logger.info child_scope.name[@organization.default_locale].parameterize

      child_assembly = Decidim::Assembly.find_or_create_by!(
        organization: @organization,
        title: child_scope.name,
        slug: child_scope.code,
        subtitle: child_scope.name,
        short_description: "<p>#{child_scope.name[@organization.default_locale]}</p>",
        description: "<p>#{scope.name[@organization.default_locale]} > #{child_scope.name[@organization.default_locale]}</p>",
        scope: child_scope,
        parent: parent_assembly
      )

      child_assembly.update!(
        hashtag: "##{scope.name[@organization.default_locale].camelize}",
        # hero_image: File.new(File.join(seeds_root, "city.jpeg")),
        # banner_image: File.new(File.join(seeds_root, "city2.jpeg")),
        promoted: false,
        published_at: 2.weeks.ago,
        meta_scope: child_scope.name
      )
    end

  end
end
