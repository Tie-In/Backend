class Api::V1::RetrospectivesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
  respond_to :json

  def create
    sprint = Sprint.find(create_params[:sprint_id])
    if sprint.retrospective.nil?
      if sprint.is_ended
        retro = Retrospective.new(create_params)
        retro.update(status: :in_progress, number: sprint.number, project: sprint.project)
        RetrospectiveContribute.new(user: current_user, retrospective: retro).save
        if retro.save
          render json: retro, status: 201
        else
          render json: { errors: retro.errors }, status: 422
        end
      else 
        render json: { errors: "Sprint is still in progress. Please, close sprint before create the retrospective" }, status: 400
      end
    else 
      render json: { msg: "Retrospective is already created" }, status: 200
    end
  end

  def update
    retro = Retrospective.find(params[:id])
    unless params[:is_important].nil?
      important_params[:viewpoints].each do |viewpoint|
        view = Viewpoint.find(viewpoint[:id])
        if view.retrospective_id.to_s == params[:id]
          view.update(is_important: true)
        end
      end
    else
      unless retro.update(update_params)
        render json: { errors: retro.errors }, status: 422
      end
    end
    render json: retro.as_json(include: [ { viewpoints: { include: [:viewpoint_category] }} ]), status: 200
  end

  def show
    retro = Retrospective.find(params[:id])
    if retro.sprint.project.users.include?(current_user)
      render json: retro.as_json(include: [ { viewpoints: { include: [:viewpoint_category] }}, :retrospective_contributes ]), status: 200
     else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  private
  def create_params
    params.require(:retrospective).permit(:sprint_id, :time_limit)
  end

  def update_params
    params.require(:retrospective).permit(:status)
  end

  def important_params
    params.require(:is_important).permit(:viewpoints => [:id])
  end
end
