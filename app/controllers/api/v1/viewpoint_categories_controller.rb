class Api::V1::ViewpointCategoriesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update]
  respond_to :json

  def create
    vc = ViewpointCategory.new(create_params)
    if vc.save
      render json: vc, status: 201
    else
      render json: { errors: vc.errors }, status: 422
    end
  end

  private
  def create_params
    params.require(:viewpoint_category).require(:name, :color, :retrospective_id)
  end
end
