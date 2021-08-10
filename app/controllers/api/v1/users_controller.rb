class Api::V1::UsersController < ApplicationController

  def create
    if params[:password].nil? || params[:password_confirmation].nil? || params[:email] == nil
      message = "you need to fill out all features"
      return_error(message)
    elsif User.find_by(email: params[:email].downcase) != nil
      message = "you cannot use this email"
      return_error(message)
    elsif params[:password] != params[:password_confirmation]
      message = "passwords do not match"
      return_error(message)
    else
      new_user = User.create(email: params[:email].downcase, password: params[:password], password_confirmation: params[:password_confirmation])
      new_user.generate_api_key
      user_with_api_key = User.find_by(email: params[:email].downcase)
      render json: UserSerializer.new(user_with_api_key)
    end
  end
end
