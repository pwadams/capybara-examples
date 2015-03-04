require 'rails_helper'

feature 'Drunk' do

  scenario 'User sees healine on root' do

    visit root_path
    expect(page).to have_content('Tristan Drinks Often')
  end

  scenario 'user can see all the beers that made Tristan drunk' do
    visit root_path
    click_on 'Make Tristan Drink a Beer'

    expect(current_path).to eq new_beer_path
    expect (page).to have_content('What should we make Tristan drink today?')
    fill_in 'Name of Beer', with: 'Colt 45'
    click_on 'Down the Hatch'

    expect(current_path).to eq root_path
    #flash message
    expect(page).to have_content 'Thank you sir, may I have another?'

    expect(page).to have_content('Colt 45')

    click_on "Hide the Evidence"
    expect(page).not_to have_content('Colt 45') 
  end
end
