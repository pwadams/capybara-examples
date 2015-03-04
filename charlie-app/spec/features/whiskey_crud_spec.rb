require 'rails_helper'

feature 'Users can CRUD whiskey' do

  before :each do
    @bourbon = Whiskey.new(name: 'Pappy Van Winkle 20 Year',
                          whiskey_type: 'Bourbon',
                          place_of_origin: 'Frankfort, KY, USA',
                          proof: 90.4)
    @bourbon.save!
    @single_malt = Whiskey.new(name: 'The Macallan Fine Oak 21 Year',
                              whiskey_type: 'Single Malt',
                              place_of_origin: 'Speyside, Scotland',
                              proof: 86)
    @single_malt.save!
  end

  scenario 'index lists all available whiskeys with name, type, place of origin, and proof' do

    visit whiskeys_path

    expect(page).to have_content 'List of Whiskeys (and Whiskies)'
    expect(page).to have_content 'Pappy Van Winkle 20 Year'
    expect(page).to have_content 'Bourbon'
    expect(page).to have_content 'Frankfort, KY, USA'
    expect(page).to have_content '90.4'
    expect(page).to have_content 'The Macallan Fine Oak 21 Year'
    expect(page).to have_content 'Single Malt'
    expect(page).to have_content 'Speyside, Scotland'
    expect(page).to have_content '86'
  end

  scenario 'User add a new Whiskey (or Whisky)' do
    visit whiskeys_path
    click_link 'New Whiskey/Whisky'

    expect(current_path).to eq new_whiskey_path
    expect(page).to have_content 'Add a New Whiskey/Whisky'

    fill_in 'Name', with: 'Johnnie Walker Blue Label'
    fill_in 'Type', with: 'Peated Blend'
    fill_in 'Place of Origin', with: 'Scotland'
    fill_in 'Proof', with: '80'
    click_button 'Add Whiskey/Whisky'

    expect(current_path).to eq whiskeys_path
    expect(page).to have_content 'Johnnie Walker Blue Label was successfully added!'
    expect(page).to have_content 'Johnnie Walker Blue Label'
    expect(page).to have_content 'Peated Blend'
    expect(page).to have_content 'Scotland'
    expect(page).to have_content '80'
  end

  scenario 'index links to show via Whiskey/Whisky name' do
    visit whiskeys_path

    click_link 'Pappy Van Winkle 20 Year'

    expect(current_path).to eq whiskey_path(@bourbon)
    expect(page).to have_content 'Name: Pappy Van Winkle 20 Year'
    expect(page).to have_content 'Type: Bourbon'
    expect(page).to have_content 'Place of Origin: Frankfort, KY, USA'
    expect(page).to have_content 'Proof: 90.4'
  end

  scenario 'show page contains links to the index, edit and destroy' do
    visit whiskeys_path
    click_link 'Pappy Van Winkle 20 Year'

    expect(current_path).to eq whiskey_path(@bourbon)
    expect(find_link('Back')[:href]).to eq(whiskeys_path)
    expect(find_link('Edit')[:href]).to eq(edit_whiskey_path(@bourbon))
    expect(find_link('Delete')[:href]).to eq(whiskey_path(@bourbon))
  end

  scenario 'User can update Whiskey/Whisky' do
    visit whiskey_path(@bourbon)
    click_link 'Edit'
    expect(current_path).to eq edit_whiskey_path(@bourbon)
    expect(page).to have_content 'Edit Whiskey/Whisky'

    fill_in 'Place of Origin', with: 'Kentucky, USA'
    click_button 'Update Whiskey/Whisky'

    expect(page).to have_content 'Pappy Van Winkle 20 Year was updated!'
    expect(current_path).to eq whiskey_path(@bourbon)
    expect(page).to have_content 'Kentucky, USA'
    expect(page).to have_no_content 'Frankfort, KY, USA'
  end

  scenario 'User can delete Whiskey/Whisky' do
    visit whiskey_path(@bourbon)
    click_link 'Delete'

    expect(current_path).to eq whiskeys_path
    expect(page).to have_content 'Pappy Van Winkle 20 Year was deleted!'

    expect { @bourbon.reload }.to raise_error ActiveRecord::RecordNotFound
  end

end
