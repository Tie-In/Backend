class Api::V1::ViewpointsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update]
  respond_to :json

  def create
    view = Viewpoint.new(create_params)
    if view.save
      view.user = current_user
      render json: view, status: 201
    else
      render json: { errors: view.errors }, status: 422
    end
  end

  def update
    view = Viewpoint.find(params[:id])
    if view.update(update_params)
      render json: view, status: 200
    else
      render json: { errors: view.errors }, status: 422
    end
  end

  private
  def create_params
    params.require(:viewpoint).require(:comment, :type, :retrospective_id)
  end

  def update_params
    params.require(:viewpoint).require(:viewpoint_category_id)
  end
end
