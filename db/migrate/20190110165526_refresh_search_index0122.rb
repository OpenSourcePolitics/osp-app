class RefreshSearchIndex0122 < ActiveRecord::Migration[5.2]
  def change

    # From decidim-core/db/migrate/20180206143340_fix_reference_for_all_resources.rb
    models = ActiveRecord::Base.descendants.select { |c| c.included_modules.include?(Decidim::HasReference) }

    models.each do |model|
      model.find_each(&:touch)
    end

    # From decidim-core/lib/decidim/searchable.rb
    Decidim::Proposals::Proposal.all.each do |p|
      unless p.nil? || p.component.nil?
        p.try_add_to_index_as_search_resource
        p.try_update_index_for_search_resource
      end
    end

    Decidim::Meetings::Meeting.all.each do |m|
      unless m.nil? || m.component.nil?
        m.try_add_to_index_as_search_resource
        # m.try_update_index_for_search_resource
      end
    end

  end
end
