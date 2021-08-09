class Api::V1::BreweriesController < ApplicationController
  def index
    location = MapFacade.get_coordinates(params[:location])
    forecast = WeatherFacade.weather_data(location)

    breweries = BreweriesFacade.location_breweries(params[:location], forecast.current_weather, params[:quantity].to_i)
# binding.pry
    render json: BrewerySerializer.new(breweries)
  end
end
