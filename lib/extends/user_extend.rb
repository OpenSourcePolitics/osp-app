# frozen_string_literal: true
require "active_support/concern"

module UserExtend
  extend ActiveSupport::Concern

  class_methods do

    def genders
      %w(male female other)
    end

    def gender_options
      self.genders.map do |gender|
        [
          I18n.t(
            gender,
            scope: %w(decidim users gender)
          ), gender
        ]
      end
    end

    def regions
      [
        "1", # GUADELOUPE
        "2", # MARTINIQUE
        "3", # GUYANE
        "4", # LA REUNION
        "6", # MAYOTTE
        "11", # ILE DE FRANCE
        "24", # CENTRE VAL DE LOIRE
        "27", # BOURGOGNE FRANCHE COMTE
        "28", # NORMANDIE
        "32", # HAUTS DE FRANCE
        "44", # GRAND EST
        "52", # PAYS DE LA LOIRE
        "53", # BRETAGNE
        "75", # NOUVELLE AQUITAINE
        "76", # OCCITANIE
        "84", # AUVERGNE RHONE ALPES
        "93", # PROVENCE ALPES COTE D AZUR
        "94", # CORSE
      ]
    end

    def region_options
      self.regions.map do |region|
        [
          I18n.t(
            region,
            scope: %w(decidim users region)
          ), region
        ]
      end
    end

  end
end

Decidim::User.send(:include, UserExtend)
