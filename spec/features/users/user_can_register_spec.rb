require "rails_helper"

RSpec.describe "Registration Happy Path" do
  it "Registers a User" do
    visit "/register"

    fill_in :user_name, with: "Happy Gilmore"
    fill_in :user_email, with: "happygilmore@gmail.com"
    fill_in :user_password, with: "golf123"
    fill_in :user_password_confirmation, with: "golf123"

    expect(current_path).to eq("/users/#{User.last.id}")
  end
end