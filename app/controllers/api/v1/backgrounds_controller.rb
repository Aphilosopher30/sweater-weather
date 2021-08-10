class Api::V1::BackgroundsController < ApplicationController
  def search
    city_picture = PicturesFacade.city_picture(params[:location])
    render json: PictureSerializer.new(city_picture)
  end

end
