require 'rails_helper'

RSpec.describe WeatherFacade do

  context 'weather_data' do
    it 'gets relevant weather data' do

      denver_weather = File.read('spec/fixtures/open_weather/denver_weather.json')

      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?lat=39.738453&lon=-104.984853&appid=#{ENV['weather_key']}&exclude=minutely,alerts").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: denver_weather, headers: {})

      denver_coordinates = {:lat=>39.738453, :lng=>-104.984853}
      test = WeatherFacade.weather_data(denver_coordinates)

      expect(test.class).to eq(Forecast)
      expect(test.current_weather).to be_a(Hash)
      expect(test.hourly_weather).to be_a(Array)
      expect(test.daily_weather).to be_a(Array)
    end
  end
end
