class Api::V1::ViewpointCategoriesController < ApplicationController
  # before_action :authenticate_with_token!, only: [:create, :update]
  respond_to :json

  def index 
    @vc = ViewpointCategory.all
    unless params[:retrospective].nil?
      @vc = @vc.where(retrospective_id: params[:retrospective])
    end
    render json: @vc, status: 200
  end

  def show
    vc = ViewpointCategory.find(params[:id])
    if vc.save
      render json: vc, status: 200
    else
      render json: { errors: vc.errors }, status: 422
    end
  end

  def create
    create_params[:viewpoint_categories].each do |viewpoint_cat_params|
      view = ViewpointCategory.new(viewpoint_cat_params)
      view.update(retrospective_id: params[:retrospective_id])
      unless view.save
        render json: { errors: view.errors }, status: 422
      end
    end
    retro = Retrospective.find(params[:retrospective_id])
    all_viewpoint_cat = retro.viewpoint_categories
    render json: all_viewpoint_cat, status: 201
  end

  private
  def create_params
    params.permit(:viewpoint_categories => [:name, :color])
  end
end
