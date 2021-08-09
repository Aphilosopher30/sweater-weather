class Api::V1::BreweriesController < ApplicationController
  def index
    location = MapFacade.get_coordinates(params[:location])
    forecast = WeatherFacade.weather_data(location)

    breweries = BreweriesFacade.location_listing(params[:location], params[:quantity])

    # render json: BrewerySerializer.new(forecast)

  end
end
