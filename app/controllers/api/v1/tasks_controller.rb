class Api::V1::TasksController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :show, :update]
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
      render json: task, include: [:tags], status: 200
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  def create
    task = Task.new(task_params)
    task.status = task.project.statuses.where(column_index: 0).first
    if task.save
      params[:tags].each do |tag|
        tag = Tag.find(tag[:id])
        temp = TaskTag.new(task: task, tag: tag)
        temp.save
      end
      render json: task, status: 200
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def update
    current_task = Task.find(params[:id])
    unless params[:row_index].nil?
      unless params[:column_id].nil?
        # move to new status
      end
      # move in old status
      new_index = params[:row_index]
      tasks = Status.find(current_task.status_id).tasks
      tasks = tasks.sort_by { |t| t["row_index"]}
      tasks.delete_at(current_task.row_index)
      tasks.insert(new_index.to_i, current_task)
      tasks.each_with_index do |task, i|
        task.update(row_index: i)
      end
      render json: current_task, include: [:tags], status: 200
    else
      if current_task.update(update_params)
        render json: current_task, include: [:tags], status: 200
      else
        render json: { errors: current_task.errors }, status: 422
      end
    end
  end

  private
  def task_params
    params.permit(:name, :description, :project_id, :feature_id, :story_point,
        :assignee_id, :estimate_time, :actual_time)
  end

  def update_params
    params.permit(:name, :description, :start_date, :end_date, :story_point,
    :sprint_id, :feature_id, :estimate_time, :actual_time, :assignee_id)
  end
end
