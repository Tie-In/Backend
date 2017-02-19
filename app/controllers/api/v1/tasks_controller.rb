class Api::V1::TasksController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :show]
	respond_to :json

	# def index
  #   unless params[:project].nil?
  #     @project_tasks = Project.find(params[:project]).tasks
	# 		unless params[:sprint].nil?
	# 			if params[:sprint].zero
	# 				@tasks = @project_tasks.where(sprint_id: nil)
	# 			else
	# 				@tasks = @project_tasks.where(sprint_id: params[:sprint])
	# 			end
	# 			render json: @tasks
	# 		end
	# 		render json: @project_tasks
  #   end
  #   render json: { errors: 'Permission denied' }, status: 401
  # end

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
