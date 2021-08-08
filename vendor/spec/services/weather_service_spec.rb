require 'rails_helper'

RSpec.describe WeatherService do

  describe "returns weather data" do
    it "returns the desired data" do

      json_response = File.read('spec/fixtures/weather/weather_report.json')

      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?lat=39.738453&lon=-104.984853&appid=#{ENV['weather_key']}&exclude=minutely,alerts").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.4.2'
          }).
        to_return(status: 200, body: json_response, headers: {})

        test = WeatherService.get_weather({:lat=>39.738453, :lng=>-104.984853})
        expected = JSON.parse(json_response, symbolize_names: true)

        expect(test).to eq(expected)
    end
  end

end
