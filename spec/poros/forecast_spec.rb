require 'rails_helper'

RSpec.describe Forecast do

  context 'the Forecast class exists and has attributes' do
    it 'has atrributes' do
      current = {:datetime=>Time.at(1628470419),
         :sunrise=>Time.at(1628424346),
         :sunset=>Time.at(1628474722),
         :temperature=>303.88,
         :feels_like=>302.13,
         :humidity=>23,
         :uvi=>0.26,
         :visibility=>10000,
         :conditions=>"overcast clouds",
         :icon=>"04d"}
      hour_first = {:time=>Time.at(1628467200), :temperature=>304.43, :conditions=>"broken clouds", :icon=>"04d"}
      hour_last =  {:time=>Time.at(1628492400), :temperature=>298.1, :conditions=>"clear sky", :icon=>"01n"}
      day_first = {:date=>Time.at(1628449200), :sunrise=>Time.at(1628424346), :sunset=>Time.at(1628474722), :max_temp=>306.08, :min_temp=>292.73, :conditions=>"clear sky", :icon=>"01d"}
      day_last = {:date=>Time.at(1628794800), :sunrise=>Time.at(1628770175), :sunset=>Time.at(1628820025), :max_temp=>306.43, :min_temp=>296.18, :conditions=>"clear sky", :icon=>"01d"}

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
