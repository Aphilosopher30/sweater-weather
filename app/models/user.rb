class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, confirmation: true, presence: true, on: :create

  has_secure_password




  def generate_api_key
    api_key = SecureRandom.hex
    # binding.pry
    while User.find_by(api_key: api_key) != nil
      api_key = SecureRandom.hex
    end
    User.update(self.id, :api_key => api_key)
    return api_key

  end








end
