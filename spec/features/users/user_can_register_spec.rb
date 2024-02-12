require "rails_helper"

RSpec.describe "Registration Happy Path" do
  xit "Registers a User" do
    visit "/register"

    fill_in :username, with: "happygilmore"
    fill_in :password, with: "golf123"
    fill_in :password_confirmation, with: "golf123"

    expect(current_path).to eq("/users")
  end
end