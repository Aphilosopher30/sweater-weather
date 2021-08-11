require 'rails_helper'

RSpec.describe MapService do

  describe "returns coordinates" do
    it "returns the desired coordinates" do

      denver_co = File.read('spec/fixtures/mapquest/denver_co.json')

      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_quest_key']}&location=Denver,CO").
               with(
                 headers: {
             	  'Accept'=>'*/*',
             	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             	  'User-Agent'=>'Faraday v1.6.0'
                 }).
               to_return(status: 200, body: denver_co, headers: {})

        coordinants = MapService.geo_coordinates('Denver,CO')
        expected = JSON.parse(denver_co, symbolize_names: true)

        expect(coordinants).to eq(expected)
    end


    it "responds to non-existant city" do
    end
    it "responds to empoty string" do
    end
  end

  describe "returns trip" do
    it "gives info on trip" do

      test = File.read('spec/fixtures/mapquest/denver_to_pueblo.json')

      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['map_quest_key']}&to=Pueblo,CO").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: test, headers: {})

        trip = MapService.directions('Denver,CO', 'Pueblo,CO')
        expected = JSON.parse(test, symbolize_names: true)

        expect(trip).to eq(expected)
    end
  end


end
