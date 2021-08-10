class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, confirmation: true, presence: true, on: :create

  has_secure_password
end
