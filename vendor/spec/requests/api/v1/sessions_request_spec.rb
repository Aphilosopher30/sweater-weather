require 'rails_helper'

RSpec.describe 'sesssions request api tests', type: :request do

  describe "user makes a new " do

    it "gives a proper response " do

      test_user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password', api_key: 'asdf')

      post '/api/v1/sessions', params: {"email": "test@test.com", "password": "password"}

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")

      user = JSON.parse(response.body, symbolize_names: true)

      expect(user[:data][:id].to_i).to eq(test_user.id)
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
      it 'wrong password' do

        test_user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password', api_key: 'asdf')

        post '/api/v1/sessions', params: {"email": "test@test.com", "password": "wrong"}
        error = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(error[:error]).to eq('your password or email is incorrect')
      end

      it 'wrong email' do

        test_user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password', api_key: 'asdf')

        post '/api/v1/sessions', params: {"email": "wrong", "password": "password"}
        error = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(error[:error]).to eq('your password or email is incorrect')
      end

      it 'empty field ' do

        test_user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password', api_key: 'asdf')

        post '/api/v1/sessions', params: {"password": "password"}
        error = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(error[:error]).to eq('plese send both an email and a password')

        post '/api/v1/sessions', params: {"email": "test@test.com"}
        error = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(error[:error]).to eq('plese send both an email and a password')

      end

    end


  end

end
