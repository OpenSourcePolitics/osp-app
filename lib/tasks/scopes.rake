# frozen_string_literal: true

require "decidim/core"
require "csv"

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
        name: "Région",
        plural: "Régions",
        csv_file: "vendor/insee/region2019.csv",
        csv_mapping: {
          code: "reg",
          name: "libelle"
        }
      })

      import_scopes({
        name: "Département",
        csv_file: "vendor/insee/departement2019.csv",
        csv_mapping: {
          code: "dep",
          parent: "reg",
          name: "libelle"
        }
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

def import_scopes(params)
  @options = {
    host: params.dig(:host),
    name: params.dig(:name),
    plural: params.dig(:plural) || params.dig(:name),
    csv_file: params.dig(:csv_file),
    csv_mapping: params.dig(:csv_mapping)
  }

  Rails.logger.info @options

  if check_file(@options[:csv_file], :csv)
    @csv = CSV.read(path_for(@options[:csv_file]), col_sep: ',', headers: true, skip_blanks: true)
  else
    Rails.logger.error "Could not load CSV file \"#{@options[:csv_file]}\""
    exit 1
  end

  @scope_type = Decidim::ScopeType.where(decidim_organization_id: @organization.id)
  .where('name @> ?', {"#{@organization.default_locale}": @options[:name]}.to_json)
  .first_or_create!(
    name: {"#{@organization.default_locale}": @options[:name]},
    plural: {"#{@organization.default_locale}": @options[:plural]}
  )

  if @options[:csv_mapping].dig(:code)
    @TYPES[@options[:csv_mapping].dig(:code)] = @scope_type

    @csv.each do |row|
      Rails.logger.info row.to_h

      _code = @options[:csv_mapping].dig(:code) + "-" + row[@options[:csv_mapping].dig(:code)]
      _name = row[@options[:csv_mapping].dig(:name)]

      _parent = @options[:csv_mapping].dig(:parent) ? Decidim::Scope.find_by(
        :decidim_organization_id => @organization.id,
        :scope_type_id => @TYPES[@options[:csv_mapping].dig(:parent)].id,
        :code => @options[:csv_mapping].dig(:parent) + "-" + row[@options[:csv_mapping].dig(:parent)]
      )&.id : nil

      scope = Decidim::Scope.find_or_initialize_by(
        decidim_organization_id: @organization.id,
        scope_type_id: @scope_type.id,
        code: _code
      ).update!(
        code: _code,
        parent_id: _parent,
        name: {"#{@organization.default_locale}": _name},
      )
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
