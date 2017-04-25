class Api::V1::ViewpointsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update]
  respond_to :json

  def create
    create_params[:viewpoints].each do |viewpoint_params|
      view = Viewpoint.new(viewpoint_params)
      view.update(user: current_user, retrospective_id: params[:retrospective_id])
      RetrospectiveContribute.new(user: current_user, retrospective_id: params[:retrospective_id]).save
      unless view.save
        render json: { errors: view.errors }, status: 422
      end
    end
    all_viewpoints = current_user.viewpoints.where(retrospective_id: params[:retrospective_id])
    render json: all_viewpoints, status: 201
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
    params.permit(:viewpoints => [:comment, :kind])
  end

  def update_params
    params.require(:viewpoint).permit(:viewpoint_category_id)
  end
end
