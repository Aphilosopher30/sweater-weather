require 'rails_helper'

RSpec.describe WeatherService do

  describe "returns coordinates" do
    it "returns the desired coordinates" do

      denver_weather = File.read('spec/fixtures/open_weather/denver_weather.json')

      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=3a8fc712d768c4590d989924f75271e0&exclude=minutely,alerts&lat=39.738453&lon=-104.984853").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: denver_weather, headers: {})

      denver = {:lat=>39.738453, :lng=>-104.984853}
      test = WeatherService.get_weather(denver)
      expected = JSON.parse(denver_weather, symbolize_names: true)

      expect(test).to eq(expected)
    end


  end

end
