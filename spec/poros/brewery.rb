require 'rails_helper'

RSpec.describe Forecast do

  context 'the Forecast class exists and has attributes' do
    it 'has atrributes' do

      weather_info = File.read('spec/fixtures/open_weather/denver_weather.json')
      weather_info = JSON.parse(weather_info, symbolize_names: true)

      forecast = Forecast.new(weather_info)

      expect(forecast.id).to eq(nil)

      expect(forecast.hourly_weather.first).to eq(hour_first)
      expect(forecast.daily_weather.first).to eq(day_first)
      expect(forecast.hourly_weather.last).to eq(hour_last)
      expect(forecast.daily_weather.last).to eq(day_last)
      expect(forecast.current_weather).to eq(current)
    end
  end
end
