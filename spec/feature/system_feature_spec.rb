# frozen_string_literal: true

require "rails_helper"

describe "system page", type: :feature do
  before do
    visit 'http://localhost:3000/system'
  end

  it "displays connection message" do
    expect(page).to have_content "Vous devez vous connecter ou vous inscrire avant de continuer."
  end
end
