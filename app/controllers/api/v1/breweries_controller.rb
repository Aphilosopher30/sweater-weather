class Api::V1::BreweriesController < ApplicationController
  def index
    location = MapFacade.get_coordinates(params[:location])
    forecast = WeatherFacade.weather_data(location)

    breweries = BreweriesFacade.local_listing(params[:location], params[:quantity].to_i)

    render json: BrewerySerializer.new(breweries)

  end
end
