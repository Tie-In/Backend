class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]
	respond_to :json

  def index
    if !params[:organization].nil?
      users = Organization.find(params[:organization]).users
    elsif !params[:project].nil?
      users = Project.find(params[:project]).users
    else
      users = User.all
    end
    # remove current user if have auth_token header
    unless request.headers['Authorization'].nil?
      users = users.reject { |a| a.id == current_user.id }
    end
    render json: users, only: [:id, :username, :email, :image]
  end

  def show
    respond_with User.find(params[:id]), except: [:auth_token], include: [:organizations, :projects]
  end

  def create
    ActiveRecord::Base.transaction do
      user = User.new(create_params)
      if user.save
        render json: user, include: [:organizations, :projects], status: 201
      else
        render json: { errors: user.errors }, status: 422
      end
    end
  end

  def update
    user = current_user
    unless params[:current_password].nil?
      current_password = params[:current_password]
      if user.valid_password? current_password
        if user.update(password: params[:new_password], password_confirmation: params[:confirm_new_password])
          render json: { massage: "Changing password done"}, statu: 200
        else
          render json: { errors: "New password incorrect" }, status: 422
        end
      else
        render json: { errors: "Current password incorrect" }, status: 422
      end
    else 
      if user.update(update_params)
        render json: user, include: [:organizations, :projects], status: 200
      else
        render json: { errors: user.errors }, status: 422
      end
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private
  def create_params
    params.require(:user).require(:password_confirmation)
    params.require(:user).permit(:email, :username, :password,
      :password_confirmation, :firstname, :lastname,
      :birth_date, :phone_number, :image)
  end

  def update_params
    params.require(:user).permit(:email, :username, :firstname, :lastname,
      :birth_date, :phone_number)
  end
end
