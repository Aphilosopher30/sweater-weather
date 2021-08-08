require 'rails_helper'

RSpec.describe 'road_trip request api tests', type: :request do

  describe "road_trip makes a new " do

    describe "gives a proper response " do
      it "it  adds a new road_trip to the data base  " do
        directions = File.read('spec/fixtures/road_trip/Valid_rout.json')

        stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=zGzfu4UzI8vL45i0cpfsLigueRzfEBW0&to=Pueblo,CO").
          with(
            headers: {
        	  'Accept'=>'*/*',
        	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        	  'User-Agent'=>'Faraday v1.4.2'
            }).
          to_return(status: 200, body: directions, headers: {})

        pueblo_coordinates = File.read('spec/fixtures/coordinates/pueblo.json')

        stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=zGzfu4UzI8vL45i0cpfsLigueRzfEBW0&location=Pueblo,CO").
          with(
            headers: {
           'Accept'=>'*/*',
           'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           'User-Agent'=>'Faraday v1.4.2'
            }).
          to_return(status: 200, body: pueblo_coordinates, headers: {})


        pueblo_weather = File.read('spec/fixtures/weather/pueblo_weather.json')

        stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=3a8fc712d768c4590d989924f75271e0&exclude=minutely,alerts&lat=38.265425&lon=-104.610415").
          with(
            headers: {
        	  'Accept'=>'*/*',
        	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        	  'User-Agent'=>'Faraday v1.4.2'
            }).
          to_return(status: 200, body: pueblo_weather, headers: {})

        user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password', api_key: 'asdf')

        road_trip = RoadTrip.find_by(start_city: 'Denver,CO')
        expect(road_trip).to eq(nil)

        post '/api/v1/road_trip', params: {"origin": "Denver,CO", "destination": "Pueblo,CO", "api_key": "#{user.api_key}"}

        # expect(response).to be_successful
        # expect(response.status).to eq(200)
        # expect(response.content_type).to eq("application/json")
        #
        # road_trip_new = JSON.parse(response.body, symbolize_names: true)

        new_road_trip = RoadTrip.find_by(start_city: 'Denver,CO')

        expect(new_road_trip.class).to eq(RoadTrip)
      end

      it "gives a proper response " do

      #   directions = File.read('spec/fixtures/road_trip/Valid_rout.json')
      #
      #   stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=zGzfu4UzI8vL45i0cpfsLigueRzfEBW0&to=Pueblo,CO").
      #     with(
      #       headers: {
      #   	  'Accept'=>'*/*',
      #   	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      #   	  'User-Agent'=>'Faraday v1.4.2'
      #       }).
      #     to_return(status: 200, body: directions, headers: {})
      #
      #   pueblo_coordinates = File.read('spec/fixtures/coordinates/pueblo.json')
      #
      #   stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=zGzfu4UzI8vL45i0cpfsLigueRzfEBW0&location=Pueblo,CO").
      #     with(
      #       headers: {
      #      'Accept'=>'*/*',
      #      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      #      'User-Agent'=>'Faraday v1.4.2'
      #       }).
      #     to_return(status: 200, body: pueblo_coordinates, headers: {})
      #
      #   pueblo_weather = File.read('spec/fixtures/weather/pueblo_weather.json')
      #
      #   stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=3a8fc712d768c4590d989924f75271e0&exclude=minutely,alerts&lat=38.265425&lon=-104.610415").
      #     with(
      #       headers: {
      #   	  'Accept'=>'*/*',
      #   	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      #   	  'User-Agent'=>'Faraday v1.4.2'
      #       }).
      #     to_return(status: 200, body: pueblo_weather, headers: {})
      #
      #   user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password', api_key: 'asdf')
      #
      #   post '/api/v1/road_trip', params: {"origin": "Denver,CO", "destination": "Pueblo,CO", "api_key": "#{user.api_key}"}
      #
      #   expect(response).to be_successful
      #   expect(response.status).to eq(200)
      #   expect(response.content_type).to eq("application/json")
      #
      #   road_trip = JSON.parse(response.body, symbolize_names: true)
      #
      #   expect(road_trip[:data][:id]).to eq(nil)
      #   expect(road_trip[:data][:type]).to eq("roadtrip")
      #
      #   expect(road_trip[:data][:attributes]).to be_a(Hash)
      #   expect(road_trip[:data][:attributes].size).to eq(4)
      #   expect(road_trip[:data][:attributes]).to have_key(:start_city)
      #   expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
      #   expect(road_trip[:data][:attributes]).to have_key(:end_city)
      #   expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
      #   expect(road_trip[:data][:attributes]).to have_key(:travel_time)
      #   expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
      #   expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
      #   expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      #   expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:weather)
      #   expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:termperature)
      end
    end

    # describe "sad paths" do
    #
    #   it 'handles impossible paths' do
    #
    #     new_york_coordinates = File.read('spec/fixtures/coordinates/new_york.json')
    #
    #     stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=zGzfu4UzI8vL45i0cpfsLigueRzfEBW0&location=New%20York,NY").
    #              with(
    #                headers: {
    #            	  'Accept'=>'*/*',
    #            	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #            	  'User-Agent'=>'Faraday v1.4.2'
    #                }).
    #              to_return(status: 200, body: new_york_coordinates, headers: {})
    #
    #     impossible_rout = File.read('spec/fixtures/road_trip/impossible_rout.json')
    #
    #     stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Yourk,UK&key=zGzfu4UzI8vL45i0cpfsLigueRzfEBW0&to=New%20York,NY").
    #           with(
    #              headers: {
    #          	  'Accept'=>'*/*',
    #          	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #          	  'User-Agent'=>'Faraday v1.4.2'
    #              }).
    #           to_return(status: 200, body: impossible_rout, headers: {})
    #
    #     weather_in_NY = File.read('spec/fixtures/weather/new_york.json')
    #
    #     stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=3a8fc712d768c4590d989924f75271e0&exclude=minutely,alerts&lat=40.713054&lon=-74.007228").
    #       with(
    #         headers: {
    #     	  'Accept'=>'*/*',
    #     	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #     	  'User-Agent'=>'Faraday v1.4.2'
    #         }).
    #       to_return(status: 200, body: weather_in_NY, headers: {})
    #
    #
    #     user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password', api_key: 'asdf')
    #
    #     post '/api/v1/road_trip', params: {"origin": "Yourk,UK", "destination": "New York,NY", "api_key": "#{user.api_key}"}
    #
    #     expect(response).to be_successful
    #     expect(response.status).to eq(200)
    #     expect(response.content_type).to eq("application/json")
    #
    #     road_trip = JSON.parse(response.body, symbolize_names: true)
    #
    #     expect(road_trip[:data][:id]).to eq(nil)
    #     expect(road_trip[:data][:type]).to eq("roadtrip")
    #
    #     expect(road_trip[:data][:attributes]).to be_a(Hash)
    #     expect(road_trip[:data][:attributes].size).to eq(4)
    #     expect(road_trip[:data][:attributes]).to have_key(:start_city)
    #     expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
    #     expect(road_trip[:data][:attributes]).to have_key(:end_city)
    #     expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
    #     expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    #     expect(road_trip[:data][:attributes][:travel_time]).to eq("impossible")
    #     expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
    #     expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    #     expect(road_trip[:data][:attributes][:weather_at_eta]).to eq({})
    #   end
    #
    #   it 'wrong user api_key' do
    #
    #     user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password', api_key: 'asdf')
    #
    #     post '/api/v1/road_trip', params: {"origin": "Denver,CO", "destination": "Pueblo,CO", "api_key": "alksjflkasdjflksd"}
    #
    #     # expect(response).to be_successful
    #     expect(response.status).to eq(401)
    #     expect(response.content_type).to eq("application/json")
    #
    #     no_access = {error: "Unauthorized"}
    #
    #     road_trip = JSON.parse(response.body, symbolize_names: true)
    #     expect(road_trip).to eq(no_access)
    #
    #   end
    #
    # end

  end
end
