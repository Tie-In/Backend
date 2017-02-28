class Api::V1::SprintsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :show]
	respond_to :json

  def show
    sprint = Sprint.find(params[:id])
    if sprint.project.users.include?(current_user)
      statuses = sprint.project.statuses
      respond_to do |format|
        format.json { render :json => { :sprint => sprint.as_json,
                                        :statuses => statuses.as_json(include: { tasks: { include: :tags }}) }}
      end
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  def create
    sprint = Sprint.new(sprint_params)
    if sprint.save
      render json: sprint, status: 200
    else
      render json: { errors: sprint.errors }, status: 422
    end
  end

  private
  def sprint_params
    params.require(:task)
      .permit(:number, :project_id, :start_date, :end_date, :sprint_points,
        :tasks => [:id])
  end
end
