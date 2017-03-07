class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :update, :destroy]
	respond_to :json

  def index
    if !params[:organization].nil?
      users = Organization.find(params[:organization]).users
    elsif !params[:project].nil?
      users = Project.find(params[:project]).users
    else
      users = User.all
    end
    users = users.reject { |a| a.id == current_user.id }
    render json: users, only: [:id, :username, :email, :image]
  end

  def show
    respond_with User.find(params[:id]), except: [:auth_token], include: [:organizations, :projects]
  end

  def create
    ActiveRecord::Base.transaction do
      user = User.new(user_params)
      if user.save
        render json: user, include: [:organizations, :projects], status: 200
      else
        render json: { errors: user.errors }, status: 422
      end
    end
  end

  def update
    user = current_user
    if user.update(user_update_params)
      render json: user, include: [:organizations, :projects], status: 200
    else
      render json: { errors: user.errors }, status: 422
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
      :birth_date, :phone_number, :image)
  end

  def user_update_params
    params.permit(:email, :username, :firstname, :lastname,
      :birth_date, :phone_number)
  end
end
