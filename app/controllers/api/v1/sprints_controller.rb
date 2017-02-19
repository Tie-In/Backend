class Api::V1::SprintsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :show]
	respond_to :json

  def show
    task = Task.find(params[:id])
    if task.project.users.include?(current_user)
      respond_with task
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: 200
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  private
  def task_params
    params.require(:task)
      .permit(:name, :description, :project_id, :feature_id, :story_point,
        :assignee_id, :estimate_time, :actual_time)
  end
end
