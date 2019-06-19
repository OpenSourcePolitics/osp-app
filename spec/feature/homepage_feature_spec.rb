# frozen_string_literal: true

require "rails_helper"

describe "home page", type: :feature do
  before do
    visit "http://localhost:3000"
  end

  it "displays menu" do
    within ".main-nav" do
      expect(page).to have_css(".main-nav__link", count: 3)
    end
  end

  it "displays hero button" do
    within ".hero-cta" do
      expect(page).to have_content "Participez"
    end
  end

  it "displays home section" do
    expect(page).to have_css(".home-section", count: 7)
  end

  it "displays footer" do
    expect(page).to have_css(".main-footer")
    expect(page).to have_css(".mini-footer")
  end

  it "displays footer links" do
    within ".footer-nav" do
      expect(page).to have_link('Titre par défaut pour faq', href: "/pages/faq")
      expect(page).to have_link('Titre par défaut pour terms-and-conditions', href: "/pages/terms-and-conditions")
      expect(page).to have_link('Titre par défaut pour accessibility', href: "/pages/accessibility")
      expect(page).to have_link('Données ouvertes', href: "/open-data/download")
    end
  end
end
