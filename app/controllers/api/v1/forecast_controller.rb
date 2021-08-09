class Api::V1::ForecastController < ApplicationController
  def show
    MapFacade.get_coordinates(params[:location])
  end

end
