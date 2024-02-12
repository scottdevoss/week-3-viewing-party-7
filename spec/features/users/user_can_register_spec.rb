require "rails_helper"

RSpec.describe "Registration" do
  it "Registers a User" do

    # As a visitor 
    # When I visit `/register`
    # I see a form to fill in my name, email, password, and password confirmation.
    # When I fill in that form with my name, email, and matching passwords,
    # I'm taken to my dashboard page `/users/:id`
    visit "/register"

    fill_in :user_name, with: "Happy Gilmore"
    fill_in :user_email, with: "happygilmore@gmail.com"
    fill_in :user_password, with: "golf123"
    fill_in :user_password_confirmation, with: "golf123"

    click_on "Create New User"

    expect(current_path).to eq("/users/#{User.last.id}")
  end

  it "Registration Sad Path - won't create new user if passwords don't match" do
    # As a visitor 
    # When I visit `/register`
    # and I fail to fill in my name, unique email, OR matching passwords,
    # I'm taken back to the `/register` page
    # and a flash message pops up, telling me what went wrong

    visit "/register"

    fill_in :user_name, with: "Happy Gilmore"
    fill_in :user_email, with: "happygilmore@gmail.com"
    fill_in :user_password, with: "golf123"
    fill_in :user_password_confirmation, with: "wrong_password"

    click_on "Create New User"

    expect(current_path).to eq("/register")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end