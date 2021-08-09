require 'rails_helper'

RSpec.describe 'forecast request api test', type: :request do

  describe "returns infomation" do
    it "returns information" do
      denver_co = File.read('spec/fixtures/mapquest/denver_co.json')

      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_quest_key']}&location=Denver,CO").
               with(
                 headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Faraday v1.6.0'
                 }).
               to_return(status: 200, body: denver_co, headers: {})

      denver_weather = File.read('spec/fixtures/open_weather/denver_weather.json')

      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['weather_key']}&exclude=minutely,alerts&lat=39.738453&lon=-104.984853").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: denver_weather, headers: {})

      get '/api/v1/forecast?location=Denver,CO'

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")

      weather_data = JSON.parse(response.body, symbolize_names: true)

      expect(weather_data[:data][:id]).to eq(nil)
      expect(weather_data[:data][:type]).to eq("forecast")

      expect(weather_data[:data][:attributes]).to be_a(Hash)
      expect(weather_data[:data][:attributes].size).to eq(3)
      expect(weather_data[:data][:attributes]).to have_key(:current_weather)
      expect(weather_data[:data][:attributes]).to have_key(:hourly_weather)
      expect(weather_data[:data][:attributes]).to have_key(:daily_weather)


      expect(weather_data[:data][:attributes][:hourly_weather]).to be_a(Array)
      expect(weather_data[:data][:attributes][:hourly_weather].length).to eq(8)
      weather_data[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour.size).to eq(4)
        expect(hour).to have_key(:time)
        expect(hour).to have_key(:temperature)
        expect(hour[:temperature]).to be_a(Float)
        expect(hour).to have_key(:conditions)
        expect(hour).to have_key(:icon)
      end

      expect(weather_data[:data][:attributes][:hourly_weather]).to be_a(Array)
      expect(weather_data[:data][:attributes][:daily_weather].length).to eq(5)
      weather_data[:data][:attributes][:daily_weather].each do |day|
        expect(day.size).to eq(7)
        expect(day).to have_key(:date)
        expect(day).to have_key(:sunrise)
        expect(day).to have_key(:sunset)
        expect(day).to have_key(:max_temp)
        expect(day).to have_key(:min_temp)
        expect(day).to have_key(:conditions)
        expect(day).to have_key(:icon)
      end

      expect(weather_data[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(weather_data[:data][:attributes][:current_weather].size).to eq(10)
      expect(weather_data[:data][:attributes][:current_weather]).to have_key(:datetime)
      expect(weather_data[:data][:attributes][:current_weather]).to have_key(:sunrise)
      expect(weather_data[:data][:attributes][:current_weather]).to have_key(:sunset)
      expect(weather_data[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(weather_data[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(weather_data[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(weather_data[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(weather_data[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(weather_data[:data][:attributes][:current_weather]).to have_key(:conditions)
      expect(weather_data[:data][:attributes][:current_weather]).to have_key(:icon)
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
