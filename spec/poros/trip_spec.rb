require 'rails_helper'

RSpec.describe Trip do

  context 'the trip class exists and has attributes' do
    it 'has atrributes' do

      data = {
              start_city: "start",
              end_city: "end",
              time: 100,
              weather_at_eta: {test:'test info'}
              }

      trip = Trip.new(data)

      expect(trip.id).to eq(nil)

      expect(trip.start_city).to eq('start')
      expect(trip.end_city).to eq('end')
      expect(trip.travel_time).to eq(100)
      expect(trip.weather_at_eta).to eq({test:'test info'})
    end
  end
end
