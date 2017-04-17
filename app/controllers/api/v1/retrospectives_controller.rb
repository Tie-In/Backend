class Api::V1::RetrospectivesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :show]
  respond_to :json

  def create
    sprint = Sprint.find(create_params[:sprint_id])
    if sprint.is_ended
      retro = Retrospective.new(create_params)
      retro.update(status: :in_progress, number: sprint.number, project: sprint.project)
      if retro.save
        render json: retro, status: 201
      else
        render json: { errors: retro.errors }, status: 422
      end
    else 
      render json: { errors: "Sprint is still in progress. Please, close sprint before create the retrospective" }, status: 400
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

  def show
    retro = Retrospective.find(params[:id])
    if retro.sprint.project.users.include?(current_user)
      render json: retro, include: [:viewpoints], status: 200
    else
      render json: { errors: 'Permission denied' }, status: 401
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
