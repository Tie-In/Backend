class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy, :profile_detail]
	respond_to :json

  def index
    unless params[:organization].nil?
      @users = Organization.find(params[:organization]).users
    else
      @users = User.all
    end
    render json: @users, only: [:id, :username, :email]
  end

  def profile_detail
    respond_with current_user, except: [:auth_token, :created_at, :updated_at]
  end

  def show
    respond_with User.find(params[:id]), except: [:auth_token], include: [:organizations, :projects]
  end

  def create
    ActiveRecord::Base.transaction do
      user = User.new(user_params)
      if user.save
        render json: user, include: [:organizations, :projects], status: 200, location: [:api, user]
      else
        render json: { errors: user.errors }, status: 422
      end
    end
  end

  def update
    user = current_user
    user_password = user_update_params[:password]
    if user.valid_password? user_password
      if user.update(user_params)
        render json:  user.to_json(:except => :auth_token), status: 200, location: [:api, user]
      else
        render json: { errors: user.errors }, status: 422
      end
    else
      render json: { errors: 'Wrong password' }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private
  def user_params
    params.require(:user).require(:password_confirmation)
    params.require(:user).permit(:email, :username, :password,
      :password_confirmation, :firstname, :lastname,
      :birth_date, :phone_number)
  end

  def user_update_params
    params.require(:user).require(:password)
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
