class ApplicationController < ActionController::API

  def return_error(message, error_code= 400)
    render json: {error: message}, :status => error_code
  end
end
