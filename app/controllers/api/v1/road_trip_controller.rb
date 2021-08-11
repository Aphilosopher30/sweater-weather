class Api::V1::RoadTripController < ApplicationController


  def create
    user = User.find_by(api_key: params[:api_key])
    origin = params[:origin]
    destination = params[:destination]
    if user == nil
      return_error("Unauthorized", 401)
    else
      trip_time = MapFacade.destination_info(origin, destination)
      weather_at_eta = WeatherFacade.weather_at_arrival(trip_time)
      # info = {start_city: origin, end_city: destination, time: trip_time[:time][:formated_time], weather_at_eta: weather_at_eta}
      trip_poro = Trip.new({start_city: origin, end_city: destination, time: trip_time[:time][:formated_time], weather_at_eta: weather_at_eta})
      new_trip = RoadTrip.create(start_city: origin, end_city: destination)
      
      render json: RoadTripSerializer.new(trip_poro)
    end
  end
end
