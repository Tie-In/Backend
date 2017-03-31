class Api::V1::UserOrganizationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
	respond_to :json

  def update
    uo = UserOrganization.find(params[:id])
    if uo.update(update_params)
      render json: uo, status: 200
    else
      render json: { errors: uo.errors }, status: 422
    end
  end

  def destroy
    uo = UserOrganization.find(params[:id])
    if uo.destroy
      render json: uo, status: 204
    else 
      render json: { errors: uo.errors }, status: 422
    end
  end

  def create
    uo = UserOrganization.new(create_params)
    uo.permission_level = "user"
    if uo.save
      render json: uo, status: 201
    else 
      render json: { errors: uo.errors }, status: 422
    end
  end

  private
  def create_params
    params.require(:user_organization).permit(:user_id, :organization_id)
  end
  def update_params
    params.require(:user_organization).permit(:permission_level)
  end
end
