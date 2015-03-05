require 'rails_helper'

feature 'Awesome Sauce' do

  scenario 'User can see homepage' do

    visit root_path
    expect(page).to have_content('Tom Brady is the greatest QB to ever play the game')
  end

  scenario 'User must be an admin to access new form' do

    visit root_path
    click_link 'Sign Up'
    fill_in :user_user_name, with: 'JoeRandom'
    fill_in :user_password, with: 'wookie'
    page.check('user_admin')
    click_button 'create snoozer'

    expect(current_path). to eq '/quotes'

    click_link 'new quote'
    expect(page).to have_content 'new admin form'
    fill_in :quote_title, with: 'the simpsons'
    fill_in :quote_quote, with: 'the goggles, they do nothing'
    click_button 'create me'

    expect(current_path). to eq '/quotes'
  end

  scenario 'Users who are not admins cannot access new form' do

    visit root_path
    click_link 'Sign uP'
    expect(current_path).to eq '/sign--up'
    expect(page).to have_content 'sign up from'

    fill_in :user_user_name, with: 'Somebody'
    fill_in :user_password, with: 'spaz'
    click_button 'create loozer'

    expect(current_path).to eq '/quotes'
    expect(page).to_not have_link 'new quote'
  end

end
