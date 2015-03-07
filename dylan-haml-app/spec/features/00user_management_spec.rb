require 'rails_helper'

feature 'User' do


  scenario 'user can visit root path and sign up' do
    visit root_path
    click_on 'Sign Up'
    expect(current_path).to eq(sign_up_path)
    fill_in 'Name', with: 'Test'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '1234'
    fill_in 'Password Confirmation', with: '1234'
    click_on 'Sign Up'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('You successfully signed up!')
  end

  scenario 'User can visit a page to sign in' do
    user = create_user
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign In!'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Thank you for signing in!')
    expect(page).to have_content('Sign Out')
  end

  scenario 'User can Sign out' do
    user = create_user
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign In!'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Thank you for signing in!')
    expect(page).to have_content('Sign Out')
    click_on 'Sign Out'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Goodbye!')
  end

  scenario 'a user cannot visit cats page unless signed in' do
    visit cats_path
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Please sign in!')
  end

end
