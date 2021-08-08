require 'rails_helper'

RSpec.describe Forecast do

  context 'the Forecast class exists and has attributes' do
    it 'has atrributes' do

      input = {
        hourly_weather: {test1: 'test1'},
        daily_weather: {test1: 'test2'},
        current_weather: {test1: 'test3'}
      }

      forecast = Forecast.new(input)


      expect(forecast.id).to eq(nil)

      expect(forecast.hourly_weather).to eq({test1: 'test1'})
      expect(forecast.daily_weather).to eq({test1: 'test2'})
      expect(forecast.current_weather).to eq({test1: 'test3'})
    end
  end
end
