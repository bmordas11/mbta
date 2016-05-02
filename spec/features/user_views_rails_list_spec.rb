require 'rails_helper'

feature 'user can view a list of commuter routes' do
  scenario 'sees a list of routes' do
    visit root_path

    expect(page).to have_content("Fairmount Line")
    expect(page).to have_content("Fitchburg Line")
    expect(page).to have_content("Framingham/Worcester Line")
    expect(page).to have_content("Franklin Line")
    expect(page).to have_content("Kingston/Plymouth Line")
    expect(page).to have_content("Lowell Line")
    expect(page).to have_content("Providence/Stoughton Line")
  end
end
