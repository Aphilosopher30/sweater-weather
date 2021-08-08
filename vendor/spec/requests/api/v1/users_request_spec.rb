require 'rails_helper'

RSpec.describe 'users request api tests', type: :request do

  describe "create a new user" do
    it "it  adds a new user to the data base  " do

      test_user = User.find_by(email: "test@test.com")

      expect(test_user).to eq(nil)

      post '/api/v1/users', params: {"email": "test@test.com", "password": "password", "password_confirmation": "password"}

      user = JSON.parse(response.body, symbolize_names: true)

      # test_user_new = User.find_by(email: user[:data][:attributes][:email])
      test_user_new = User.find_by(email: "test@test.com")

      expect(test_user_new.class).to eq(User)
    end

    it "gives a proper response " do

      post '/api/v1/users', params: {"email": "test@test.com", "password": "password", "password_confirmation": "password"}

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")

      user = JSON.parse(response.body, symbolize_names: true)
      # binding.pry
      expect(user[:data][:id]).to be_a(String)
      expect(user[:data][:type]).to eq("users")

      expect(user[:data][:attributes]).to be_a(Hash)
      expect(user[:data][:attributes].size).to eq(2)
      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to be_a(String)
      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)
      expect(user[:data][:attributes]).to_not have_key(:password)
    end

    describe "sad paths" do
      it 'paswords do not match' do

        post '/api/v1/users', params: {"email": "test@test.com", "password": "pard", "password_confirmation": "password"}
        error = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(error[:error]).to eq('passwords do not match')
      end

      it 'email already in use' do
        pre_existing_user = User.create(email: "test@ts.com", password: 'password', password_confirmation: 'password', api_key: "testit")

        post '/api/v1/users', params: {"email": "test@ts.com", "password": "password", "password_confirmation": "password"}
        error = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(error[:error]).to eq('you cannot use this email')
      end

      it 'when field left blank' do

        post '/api/v1/users', params: {"email": nil, "password": "password", "password_confirmation": "password"}
          error = JSON.parse(response.body, symbolize_names: true)
          expect(response.status).to eq(400)
          expect(error[:error]).to eq('you need to fill out all features')

        post '/api/v1/users', params: {"email": "test@ts.com", "password": nil, "password_confirmation": "password"}
          error = JSON.parse(response.body, symbolize_names: true)
          expect(response.status).to eq(400)
          expect(error[:error]).to eq('you need to fill out all features')

        post '/api/v1/users', params: {"email": "test@ts.com", "password": "nil", "password_confirmation": nil}
          error = JSON.parse(response.body, symbolize_names: true)
          expect(response.status).to eq(400)
          expect(error[:error]).to eq('you need to fill out all features')

        post '/api/v1/users', params: {"email": "test@ts.com", "password": nil, "password_confirmation": nil}
          error = JSON.parse(response.body, symbolize_names: true)
          expect(response.status).to eq(400)
          expect(error[:error]).to eq('you need to fill out all features')

        post '/api/v1/users', params: {"email": nil, "password": nil, "password_confirmation": nil}
          error = JSON.parse(response.body, symbolize_names: true)
          expect(response.status).to eq(400)
          expect(error[:error]).to eq('you need to fill out all features')
      end

    end


  end

end
