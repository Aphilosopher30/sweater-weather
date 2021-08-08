require 'rails_helper'

RSpec.describe 'coordinates request api tests', type: :request do

  describe "returns background picture" do
    it "returns the desired picts" do

      json_response = File.read('spec/fixtures/pictures.json')

      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['photo_key']}&query=denver,co").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.4.2'
          }).
        to_return(status: 200, body: json_response, headers: {})

        get '/api/v1/backgrounds?location=denver,co'


        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")
    end
  end

end
