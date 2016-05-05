require 'rails_helper'

feature 'user can view a list of stops for a rail' do
  scenario 'sees a list of stops' do
    visit root_path
    click_link "Framingham/Worcester Line"

    expect(page).to have_content("South Station")
    expect(page).to have_content("Back Bay")
    expect(page).to have_content("Auburndale")
    expect(page).to have_content("Wellesley Farms")
    expect(page).to have_content("Wellesley Hills")
    expect(page).to have_content("Wellesley Square")
    expect(page).to have_content("Southborough")
    expect(page).to have_content("Grafton")
    expect(page).to have_content("Worcester")
  end
end
