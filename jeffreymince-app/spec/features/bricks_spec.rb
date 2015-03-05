require 'rails_helper'

feature 'User can crud a brick' do

  scenario "User creates a new brick" do
    visit new_brick_path
    click_on 'New Brick'
    fill_in 'height', with: 'height'
    fill_in 'weight', with: 'weight'
    fill_in 'color', with: 'color'
    click_on 'Create Brick'

    expect(page).to have_content('height')
    expect(page).to have_content('weight')
    expect(page).to have_content('color')

   end

    scenario "User can see a show page" do
    visit brick_path
    fill_in 'height', with: 'height'
    fill_in 'weight', with: 'weight'
    fill_in 'color', with: 'color'

    expect(page).to have_content('height')
    expect(page).to have_content('weight')
    expect(page).to have_content('color')


  end
end
