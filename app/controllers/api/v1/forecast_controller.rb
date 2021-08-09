class Api::V1::ForecastController < ApplicationController
  def show
    location = MapFacade.get_coordinates(params[:location])
    forcast = WeatherFacade.weather_data(location)
    
  end
end
