require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_confirmation_of(:password) }

  end


  describe 'generate api key' do
    it 'returns an api_key' do
      test_user = User.create(email: "test@test.com", password: 'password', password_confirmation: 'password')

      test = test_user.generate_api_key

      expect(test.class).to eq(String)
    end

    it 'changes the api key of the user' do
      test_user = User.create(email: "test@test.com", password: 'password', password_confirmation: 'password')

      expect(test_user.api_key).to eq(nil)

      new_key = test_user.generate_api_key
      test_user = User.find_by(email: "test@test.com")

      expect(test_user.api_key).to_not eq(nil)
      expect(test_user.api_key).to eq(new_key)

      new_key_2 = test_user.generate_api_key
      test_user = User.find_by(email: "test@test.com")

      expect(test_user.api_key).to_not eq(new_key)
      expect(test_user.api_key).to eq(new_key_2)
    end

    it 'makes api key unique' do

    end


  end


end
