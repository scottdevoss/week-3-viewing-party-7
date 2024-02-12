class User <ApplicationRecord 
  validates_presence_of :email, :name 
  validates_uniqueness_of :email
  has_many :viewing_parties
  validates :password_digest, presence: true

  has_secure_password
end 