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

  it "User can log out" do
    # As a logged-in user 
    # When I visit the landing page
    # I no longer see a link to Log In or Create an Account
    # But I only see a link to Log Out.
    # When I click the link to Log Out,
    # I'm taken to the landing page
    # And I see that the Log Out link has changed back to a Log In link
    # And I still see the Create an Account button. 
    @user = User.create!(name: "Peyton Manning", email: "peyton@example.com", password: "football", password_confirmation: "football")
    @user2 = User.create!(name: "Patrick Mahomes", email: "mahomies@example.com", password: "football123", password_confirmation: "football123")
    
    visit "/"

    click_on "Log In"

    expect(current_path).to eq("/login")

    fill_in :email, with: "peyton@example.com"
    fill_in :password, with: "football"

    click_button "Log In"

    expect(current_path).to eq("/users/#{@user.id}")

    visit "/"

    expect(page).to_not have_link("Log In")
    expect(page).to_not have_button("Create New User")
    expect(page).to have_link("Log Out")  

    click_on "Log Out"

    expect(current_path).to eq("/")

    expect(page).to have_link("Log In")
    expect(page).to have_button("Create New User")
    expect(page).to_not have_link("Log Out")
  end

  it "logged out users see limited info on landing page" do
    # As a visitor
    # When I visit the landing page
    # I do not see the section of the page that lists existing users

    visit "/"

    expect(page).to_not have_content("Existing Users:")
  end

  it "Logged-in users no longer see links on landing page" do
    # As a logged-in user
    # When I visit the landing page 
    # The list of existing users is no longer a link to their show pages
    # But just a list of email addresses

    @user = User.create!(name: "Peyton Manning", email: "peyton@example.com", password: "football", password_confirmation: "football")
    @user2 = User.create!(name: "Patrick Mahomes", email: "mahomies@example.com", password: "football123", password_confirmation: "football123")

    visit "/"

    click_on "Log In"

    expect(current_path).to eq("/login")

    fill_in :email, with: "peyton@example.com"
    fill_in :password, with: "football"

    click_button "Log In"

    expect(current_path).to eq("/users/#{@user.id}")

    visit "/"

    expect(page).to have_content("mahomies@example.com")
    expect(page).to have_content("peyton@example.com")
    expect(page).to_not have_link("mahomies@example.com")
    expect(page).to_not have_link("peyton@example.com")
  end

  it "Dashboard authorization" do
    #   As a visitor
    #   When I visit the landing page
    #   And then try to visit the user's dashboard ('/users/:user_id')
    #   I remain on the landing page
    #   And I see a message telling me that I must be logged in or registered to access a user's dashboard.

    @user = User.create!(name: "Peyton Manning", email: "peyton@example.com", password: "football", password_confirmation: "football")
    @user2 = User.create!(name: "Patrick Mahomes", email: "mahomies@example.com", password: "football123", password_confirmation: "football123")

    visit "/"

    visit "/users/#{@user.id}"

    expect(page).to have_content("You must be logged in or registered to access a user's dashboard")
  end
end 