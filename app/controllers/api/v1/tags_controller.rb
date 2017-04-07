class Api::V1::TagsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
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
      render json: tag, status: 200
    else
      render json: { errors: tag.errors }, status: 422
    end
  end

  private
  def create_params
    params.permit(:name, :color, :project_id)
  end
end
