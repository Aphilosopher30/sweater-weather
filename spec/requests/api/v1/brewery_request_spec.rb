require 'rails_helper'

RSpec.describe 'forecast request api test', type: :request do

  describe "returns infomation" do
    it "returns information" do

      

      get '/api/v1/breweries?location=denver,co&quantity=5'

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")

      response = JSON.parse(response.body, symbolize_names: true)

      expect(response[:data][:id]).to eq(nil)
      expect(response[:data][:type]).to eq("breweries")

      expect(response[:data][:attributes]).to be_a(Hash)
      expect(response[:data][:attributes].size).to eq(3)
      expect(response[:data][:attributes]).to have_key(:destination)
      expect(response[:data][:attributes]).to have_key(:forecast)
      expect(response[:data][:attributes]).to have_key(:breweries)


      expect(response[:data][:attributes][:destination]).to be_a(String)
      expect(response[:data][:attributes][:destination]).to eq(denver,co)

      expect(response[:data][:attributes][:breweries]).to be_a(Array)
      expect(response[:data][:attributes][:breweries].length).to eq(5)
      response[:data][:attributes][:breweries].each do |brewery|
        expect(brewery).to be_a(Hash)
        expect(brewery.size).to eq(7)
        expect(brewery).to have_key(:id)
        expect(brewery).to have_key(:name)
        expect(brewery).to have_key(:brewery_type)
      end

      expect(response[:data][:attributes][:forecast]).to be_a(hash)
      expect(response[:data][:attributes][:forecast].size).to eq(2)
      expect(response[:data][:attributes][:forecast]).to have_key(:summary)
      expect(response[:data][:attributes][:forecast]).to have_key(:temperature)
    end
  end

  describe "sad paths" do
    it "given a no paramiters" do
    end

    it 'gets a city state that doesnt exit' do
    end

    it 'gets number' do
    end
  end


end
