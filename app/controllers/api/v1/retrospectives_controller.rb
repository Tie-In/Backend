class Api::V1::RetrospectivesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update]
  respond_to :json

  def create
    retro = Retrospective.new(create_params)
    retro.update(status: :in_progress, number: retro.sprint.number, project: retro.sprint.project)
    if retro.save
      render json: retro, status: 201
    else
      render json: { errors: retro.errors }, status: 422
    end
  end

  def update
    retro = Retrospective.find(params[:id])
    if retro.update(update_params)
      render json: retro, status: 200
    else
      render json: { errors: retro.errors }, status: 422
    end
  end

  private
  def create_params
    params.require(:retrospective).permit(:sprint_id)
  end

  def update_params
    params.require(:retrospective).permit(:status)
  end
end
