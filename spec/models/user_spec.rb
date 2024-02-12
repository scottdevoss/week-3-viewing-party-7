require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}

    it { should validate_presence_of(:password_digest)} 
    it { should have_secure_password}

    
    user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123') 
    it "does not have password attribute" do
      expect(user).to_not have_attribute(:password)
    end 
    it "password digest does not equal password" do
      expect(user.password_digest).to_not eq('password123')
    end
  end 
end
