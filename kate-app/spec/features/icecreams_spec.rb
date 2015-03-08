require "rails_helper"


feature "Ice Cream" do

  scenario "User can see an index of all their favorite ice creams" do
    visit root_path
    expect(page).to have_content "Inventory of All Your Favorite Ice Cream"
    expect(page).to have_content "Flavor"
    expect(page).to have content "Description"
    expect(page).to have content "Company"
    expect(page).to have content "Allergens"
  end

  scenario "User can create a new ice cream record" do
    visit root_path
    click_on "Add a new ice cream"
    expect(current_path).to eq(new_ice_cream_path)
    expect(page).to have_content "Create a new ice cream flavor"
    fill_in :flavor, with: "Butter pecan"
    fill_in :description, with: "It's your standard butter pecan, but with such a rich, subtle flavor. The ice cream itself almost tastes nutty."
    fill_in :company, with: "Sweet Cow"
    fill_in :allergens, with: "dairy, nuts"
    click_on "Create a new record!"
    expect(current_path).to eq(root_path)
    expect(page).to have_content "Congrats! You just added a new ice cream!"
  end

  scenario "User can see an individual ice cream record"
    butter_pecan = IceCream.create!(
      flavor: "butter pecan",
      description: "yummy in my tummy",
      company: "Sweet Cow",
      allergens: "dairy, nuts"
    )
    visit root_path
    click_on butter_pecan.name
    expect(current_path).to eq ice_cream_path(butter_pecan)
  end

end
