require 'rails_helper'

feature 'Sandwich shop' do
  scenario 'Visitors can see a list of all sandwiches' do
    Sandwich.create!(name: "Smoky Sub", price: 4.25, notes: 'gluten free')
    visit root_path
    expect(page).to have_content("Sandwich Menu")
    expect(page).to have_content("Smoky Sub - $4.25, gluten free")
  end

  scenario 'Visitors can see individual sandwich show pages by clicking on sandwich name' do
    roast_beef = Sandwich.create!(name: "Roasty Toasty", price: 5.00, notes: "too much meat")
    visit root_path
    click_on "Roasty Toasty"
    expect(page).to have_content("Roasty Toasty")
    expect(page).to have_content("Notes: too much meat")
  end

  scenario 'Logged in users can add new sandwiches' do
    sign_in
    click_on "Add New Sandwich to Menu"
    fill_in "Name", with: "Brisket Basket"
    fill_in "Price", with: 7.25
    fill_in "Notes", with: "dairy free"
    click_on "Add Sandwich"
    expect(page).to have_content("Brisket Basket - $7.25, dairy free")
  end

  scenario 'Logged in users can edit sandwiches' do
    sign_in
    tuna = Sandwich.create!(name: "Terrible Tuna", price: 3.50, notes: "shop special")
    visit sandwich_path(tuna)
    click_on "Edit"
    fill_in "Name", with: "Terrific Tuna"
    click_on "Update Sandwich"
    expect(page).to have_content("Terrific Tuna - $3.50")
    expect(page).not_to have_content("Terrible Tuna")
    expect(current_path).to eq("/")
  end

  scenario 'Logged in users can delete sandwiches' do
    sign_in
    roast_beef = Sandwich.create!(name: "Roasty Toasty", price: 5.00, notes: "too much meat")
    visit sandwich_path(roast_beef)
    click_on "Delete"
    expect { roast_beef.reload }.to raise_error ActiveRecord::RecordNotFound
    expect(page).to have_content("Roasty Toasty has been removed from the menu")
    expect(current_path).to eq("/")
  end

  scenario 'Non-logged in people cannot modify sandwiches and are redirected to root' do
    visit new_sandwich_path
    expect(page).to have_content("Oops! You must be a logged-in user to access that page")
  end
end
