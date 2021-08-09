class Api::V1::ForecastController < ApplicationController
  def show
    location = MapFacade.get_coordinates(params[:location])
    forecast = WeatherFacade.weather_data(location)
    render json: ForecastSerializer.new(forecast)
  end
end
