class Api::V1::SessionsController < ApplicationController

  def login
    if params[:email] != nil
      user = User.find_by(email: params[:email].downcase)
    end

    if params[:password] == nil || params[:email] == nil
      message =  "plese send both an email and a password"
      return_error(message)
    elsif user == nil
      message = "your password or email is incorrect"
      return_error(message)
    elsif user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      message = "your password or email is incorrect"
      return_error(message)
    end
  end
end
