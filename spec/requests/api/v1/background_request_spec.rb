require 'rails_helper'

RSpec.describe 'coordinates request api tests', type: :request do

  describe "returns background picture" do
    it "returns the desired picts" do

      picture_api = File.read('spec/fixtures/unsplash/denver_co.json')

      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['photo_key']}&query=denver,co").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: picture_api, headers: {})

        get '/api/v1/backgrounds?location=denver,co'


        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        picture_data = JSON.parse(response.body, symbolize_names: true)
      
        expect(picture_data[:data][:id]).to eq(nil)
        expect(picture_data[:data][:type]).to eq("image")
        expect(picture_data[:data][:attributes][:image_url]).to eq("https://images.unsplash.com/photo-1619856699906-09e1f58c98b1?ixid=MnwyMzk1NTh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2Mjg1NDk4NzE&ixlib=rb-1.2.1")
        expect(picture_data[:data][:attributes][:credits][:source]).to eq("From unsplash.com")
        expect(picture_data[:data][:attributes][:credits][:photographer]).to eq("Ryan De Hamer")
    end
  end

end
