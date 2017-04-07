class Api::V1::ProjectContributesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
	respond_to :json

  def update
    pc = ProjectContribute.find(params[:id])
    if pc.update(update_params)
      render json: pc, status: 200
    else
      render json: { errors: pc.errors }, status: 422
    end
  end

  def destroy
    pc = ProjectContribute.find(params[:id])
    if pc.destroy
      render json: pc, status: 204
    else 
      render json: { errors: pc.errors }, status: 422
    end
  end

  def create
    pc = ProjectContribute.new(create_params)
    pc.permission_level = "user"
    if pc.save
      render json: pc, status: 201
    else 
      render json: { errors: pc.errors }, status: 422
    end
  end

  private
  def create_params
    params.require(:project_contribute).permit(:user_id, :project_id)
  end
  def update_params
    params.require(:project_contribute).permit(:permission_level)
  end
end
