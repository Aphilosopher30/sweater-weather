require 'rails_helper'

RSpec.describe MapFacade do

  context ' obtaining coordinates' do
    it 'gets coordinates' do
      denver_co = File.read('spec/fixtures/mapquest/denver_co.json')

      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_quest_key']}&location=Denver,CO").
               with(
                 headers: {
             	  'Accept'=>'*/*',
             	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             	  'User-Agent'=>'Faraday v1.6.0'
                 }).
               to_return(status: 200, body: denver_co, headers: {})

      test = MapFacade.get_coordinates("Denver,CO")

      expect(test).to eq({:lat=>39.738453, :lng=>-104.984853})
    end
  end

  context 'collecting information for trip' do
    it 'determines the time a trip will take' do

      pueblo_trip = File.read('spec/fixtures/mapquest/denver_to_pueblo.json')

      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['map_quest_key']}&to=Pueblo,Co").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: pueblo_trip, headers: {})


      test = MapFacade.rout_time_hours("Denver,CO", "Pueblo,Co")

      expected = {:formated_time=>"01:44:22", :hours=>2}
      expect(test).to eq(expected)
    end
    it 'includes the coordinates for the final desitnation ' do
      pueblo_trip = File.read('spec/fixtures/mapquest/denver_to_pueblo.json')

      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['map_quest_key']}&to=Pueblo,Co").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: pueblo_trip, headers: {})

      pueblo_trip = File.read('spec/fixtures/mapquest/pueblo_co.json')

      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_quest_key']}&location=Pueblo,Co").
        with(
          headers: {
      	  'Accept'=>'*/*',
      	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      	  'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: pueblo_trip, headers: {})

      test = MapFacade.destination_info("Denver,CO", "Pueblo,Co")

      expected = {:coordinates=>{:lat=>38.265425, :lng=>-104.610415}, :time=>{:formated_time=>"01:44:22", :hours=>2}}
      expect(test).to eq(expected)

      expect(test[:coordinates]).to be_a(Hash)
      expect(test[:time]).to be_a(Hash)
    end

    it 'fromats time the trip would take even when the roads are closed  ' do
      roads_closed = File.read('spec/fixtures/mapquest/roads_closed.json')

      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Houlto,MA&key=#{ENV['map_quest_key']}&to=Los%20Angeles,CA").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: roads_closed, headers: {})

      los_angeles = File.read('spec/fixtures/mapquest/los_angeles.json')

      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_quest_key']}&location=Los%20Angeles,CA").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: los_angeles, headers: {})


      test = MapFacade.destination_info("Houlto,MA", "Los Angeles,CA")

      expected = {:coordinates=>{:lat=>34.052238, :lng=>-118.243344}, :time=>{:formated_time=>"43:21:09", :hours=>43}}
      expect(test).to eq(expected)

      expect(test[:coordinates]).to be_a(Hash)
      expect(test[:time]).to be_a(Hash)
    end
  end
end
