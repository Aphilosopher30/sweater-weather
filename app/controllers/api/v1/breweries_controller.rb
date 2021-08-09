class Api::V1::BreweriesController < ApplicationController
  def index
    location = MapFacade.get_coordinates(params[:location])
    forecast = WeatherFacade.weather_data(location)

    breweries = BreweriesFacade.local_listing(params[:location],forecast.current_weather, params[:quantity].to_i)
binding.pry
    render json: breweries, status: 200

  end
end
