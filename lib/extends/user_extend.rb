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
        "84", # AUVERGNE RHONE ALPES
        "27", # BOURGOGNE FRANCHE COMTE
        "53", # BRETAGNE
        "24", # CENTRE VAL DE LOIRE
        "94", # CORSE
        "44", # GRAND EST
        "32", # HAUTS DE FRANCE
        "11", # ILE DE FRANCE
        "28", # NORMANDIE
        "75", # NOUVELLE AQUITAINE
        "76", # OCCITANIE
        "52", # PAYS DE LA LOIRE
        "93", # PROVENCE ALPES COTE D AZUR
        "1", # GUADELOUPE
        "2", # MARTINIQUE
        "3", # GUYANE
        "4", # LA REUNION
        "6", # MAYOTTE
        "98", # NOUVELLE CALEDONIE
        "99", # FRANCAIS DE L ETRANGER
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
