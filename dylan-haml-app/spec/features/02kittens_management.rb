require 'rails_helper'

feature 'A User can crud kittens for a cat' do

  before :each do
    User.destroy_all
    user = create_user
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign In!'
  end

  scenario 'A User can visit a page and see a list of the kittens of a cat' do
    cat = create_cat
    kitten1 = create_kitten(cat)
    kitten2 = create_kitten(cat)
    
    visit cat_kittens_path
    expect(page).to have_content 'List of kittens'
    expect(page).to have_content 'Name: Opal'
    expect(page).to have_content 'Name: Foo'
    expect(page).to have_content 'Name: Bar'
  end

  scenario 'A User can visit a kittens show page and edit the kitten' do
    cat = create_can
    cat.kittens.create!(name: 'Opal')
    click_on 'Opal'
    expect(current_page).to eq(cat_kitten_path(cat, kitten))
    expect(current_page).to have_content('Opal')
    click_on 'Edit'
    expect(current_page).to eq(edit_cat_kitten_path(cat, kitten))
  end


end
