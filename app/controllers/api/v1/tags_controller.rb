class Api::V1::TagsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
	respond_to :json

  def index
    unless params[:project].nil?
      tags = Project.find(params[:project]).tags
    end
    render json: tags
  end

  def create
    tag = Tag.new(create_params)
    if tag.save
      render json: tag, status: 201
    else
      render json: { errors: tag.errors }, status: 422
    end
  end

  def update
    tag = Tag.find(params[:id])
    if tag.update(update_params)
      render json: tag, status: 200
    else
      render json: { errors: tag.errors }, status: 422
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    head 204
  end

  private
  def create_params
    params.require(:tag).permit(:name, :color, :project_id)
  end
  def update_params
    params.require(:tag).permit(:name, :color)
  end
end
