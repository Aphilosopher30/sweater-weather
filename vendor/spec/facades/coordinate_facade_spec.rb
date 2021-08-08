require 'rails_helper'

RSpec.describe CoordinateFacade do

  context ' obtaining coordinates' do
    it 'gets coordinates' do
      json_response = File.read('spec/fixtures/coordinates/coordinates.json')

      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_quest_key']}&location=Denver,CO").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.4.2'
          }).
        to_return(status: 200, body: json_response, headers: {})

      test = CoordinateFacade.get_coordinates("Denver,CO")


      expect(test).to eq({:lat=>39.738453, :lng=>-104.984853})
    end
  end
  context 'collecting information for trip' do
    it 'determines the time a trip will take' do

      pueblo_trip = File.read('spec/fixtures/coordinates/denver_to_pueblo_trip.json')

      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['map_quest_key']}&to=Pueblo,Co").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.4.2'
          }).
        to_return(status: 200, body: pueblo_trip, headers: {})

      test = CoordinateFacade.rout_time_hours("Denver,CO", "Pueblo,Co")

      expected = {:formated_time=>"01:44:22", :hours=>2}
      expect(test).to eq(expected)
    end


    it 'determines the time a trip will take' do

      pueblo_trip = File.read('spec/fixtures/coordinates/denver_to_pueblo_trip.json')

      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['map_quest_key']}&to=Pueblo,Co").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.4.2'
          }).
        to_return(status: 200, body: pueblo_trip, headers: {})

      pueblo = File.read('spec/fixtures/coordinates/pueblo.json')


      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_quest_key']}&location=Pueblo,Co").
        with(
          headers: {
      	  'Accept'=>'*/*',
      	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      	  'User-Agent'=>'Faraday v1.4.2'
          }).
        to_return(status: 200, body: pueblo, headers: {})

      test = CoordinateFacade.destination_info("Denver,CO", "Pueblo,Co")

      expected = {:coordinates=>{:lat=>38.265425, :lng=>-104.610415}, :time=>{:formated_time=>"01:44:22", :hours=>2}}
      expect(test).to eq(expected)

      expect(test[:coordinates]).to be_a(Hash)
      expect(test[:time]).to be_a(Hash)
    end

  end
end
