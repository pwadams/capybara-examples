require 'rails_helper'

feature 'Cats Crud' do

  before :each do
    User.destroy_all
    user = create_user
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign In!'
  end

  scenario 'when a user visits the cats page they can do things' do
    visit cats_path
    expect(page).to have_content('List of Cats')
  end

  scenario 'a user can create a new cat' do

    visit_cats_path
    expect(page).to have_content 'New Cat'
    click_on 'New Cat'
    expect(current_path).to eq(new_cat_path)
    expect(page).to have_content('Adopt a new cat')
    fill_in 'Name', with: 'Sparkle'
    fill_in 'Age', with: 5
    check 'Friendly'
    click_on 'Adopt Cat'
    expect(current_path).to eq(cats_path)
    expect(page).to have_content('Name: Sparkle')
    expect(page).to have_content('Age: 5 years old')
    expect(page).to have_content('Friendly: true')
    expect(page).to have_content('Congratulations on your new cat!')
  end

  scenario 'a user can edit a cat' do
    cat = create_cat
    visit cats_path
    expect(page).to have_content 'Edit'
    click_on 'Edit'
    expect(current_path).to eq(edit_cat_path(cat))
    fill_in 'Name', with: 'Fluffy'
    check 'Friendly'
    click_on 'Update'
    expect(current_path).to eq(cats_path)
    expect(page).to have_content("Name: #{cat.name}")
    expect(page).to have_content("Age: #{cat.age}")
    expect(page).to have_content("Friendly: #{cat.friendly}")
    expect(page).to have_content("You changed #{cat.name}'s stats!")
  end

  scenario 'a user can delete a cat' do
    cat = create_cat
    visit cats_path
    expect(page).to have_content 'Delete'
    expect(page).to have_content "Name: #{cat.name}"
    click_on 'Delete'
    expect(page).to have_content 'Your cat ran away!'
    expect(page).to have_no_content "Name: #{cat.name}"
  end

  scenario 'A user can visit a cat show page' do
    cat = create_cat
    visit cats_path
    click_on cat.name
    expect(current_path).to eq(cat_path(cat))
    expect(page).to have_content cat.name
    expect(page).to have_content cat.age
    expect(page).to have_content cat.friendly
    expect(page).to have_content 'See this cat\'s kittens!'
  end

end
