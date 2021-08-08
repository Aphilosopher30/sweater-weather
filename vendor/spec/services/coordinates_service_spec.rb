require 'rails_helper'

RSpec.describe CoordinatesService do

  describe "returns coordinates" do
    it "returns the desired coordinates" do

      json_response = File.read('spec/fixtures/coordinates/coordinates.json')


      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_quest_key']}&location=Denver,CO").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.4.2'
          }).
        to_return(status: 200, body: json_response, headers: {})

        test = CoordinatesService.geo_coordinates('Denver,CO')
        expected = JSON.parse(json_response, symbolize_names: true)

        expect(test).to eq(expected)
    end
  end

end
