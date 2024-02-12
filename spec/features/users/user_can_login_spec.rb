require "rails_helper"

RSpec.describe "User Log In" do
  it "User Can Log In" do

    # As a registered user
    # When I visit the landing page `/`
    # I see a link for "Log In"
    # When I click on "Log In"
    # I'm taken to a Log In page ('/login') where I can input my unique email and password.
    # When I enter my unique email and correct password 
    # I'm taken to my dashboard page
    @user = User.create!(name: "Peyton Manning", email: "peyton@example.com", password: "football", password_confirmation: "football")
    
    visit "/"

    click_on "Log In"

    expect(current_path).to eq("/login")

    fill_in :email, with: "peyton@example.com"
    fill_in :password, with: "football"

    click_button "Log In"

    expect(current_path).to eq("/users/#{@user.id}")
  end

  it "Logging In Sad Path" do
    # As a registered user
    # When I visit the landing page `/`
    # And click on the link to go to my dashboard
    # And fail to fill in my correct credentials 
    # I'm taken back to the Log In page
    # And I can see a flash message telling me that I entered incorrect credentials.
    @user = User.create!(name: "Peyton Manning", email: "peyton@example.com", password: "football", password_confirmation: "football")

    visit "/"

    click_link "Log In"

    fill_in :email, with: "peyton@example.com"
    fill_in :password, with: "wrong_password"

    click_button "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid credentials")
  end
end 