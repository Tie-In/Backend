class Api::V1::TasksController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :show]
	respond_to :json

  def index
    unless params[:project].nil?
      project = Project.find(params[:project])
      if params[:sprint] == "backlog"
        @tasks = Task.where(project: project, sprint: nil)
      elsif params[:sprint]
        @tasks = Task.where(project: project, sprint: params[:sprint])
      else
        @tasks = project.tasks
      end
    else
      @tasks = Task.all
    end
  end

  def show
    @task = Task.find(params[:id])
    if @task.project.users.include?(current_user)
      @task
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  def create
    task = Task.new(create_params)
    if task.save
      unless params[:tags].nil?
        params[:tags].each do |tag|
          tag = Tag.find(tag[:id])
          temp = TaskTag.new(task: task, tag: tag)
          temp.save
        end
      end
      render json: task, status: 200
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def update
    current_task = Task.find(params[:id])
    last_status_id = current_task.project.statuses.last.id
    unless params[:row_index].nil?
      unless params[:column_id].nil?
        # move to new status
        new_status = Status.find(params[:column_id])
        current_task.update(status: new_status, row_index: new_status.tasks.size)
        if params[:column_id] === last_status_id
          current_task.update(is_done: true, done_date: Date.today)
        else 
          current_task.update(is_done: false, done_date: nil)
        end
      end
      # move in old status
      new_index = params[:row_index]
      tasks = Status.find(current_task.status_id).tasks
      unless tasks.empty?
        tasks = tasks.sort_by { |t| t["row_index"]}
        tasks.delete_at(current_task.row_index)
        tasks.insert(new_index.to_i, current_task)
      end
      tasks.each_with_index do |task, i|
        task.update(row_index: i)
      end
      render json: current_task, include: [:tags], status: 200
    else
      if current_task.update(update_params)
        all_links = TaskTag.where(task_id: current_task.id)
        all_links.destroy_all
        unless params[:tags].nil?
          params[:tags].each do |tag|
            tag = Tag.find(tag[:id])
            temp = TaskTag.new(task: current_task, tag: tag)
            temp.save
          end
        end
        statuses = current_task.project.statuses
        temp_statuses = statuses
        # render all status in project (bad way)
        respond_to do |format|
          format.json { render :json => { :task => current_task.as_json(include: [:tags, :feature, :user]),
                                          :statuses => temp_statuses.as_json(include: { tasks: { include: [:tags, :feature] }}) }}
        end
        # render json: current_task, include: [:tags, :feature], status: 200
      else
        render json: { errors: current_task.errors }, status: 422
      end
    end
  end

  private
  def create_params
    params.permit(:name, :description, :project_id, :feature_id, :story_point,
        :assignee_id, :estimate_time, :actual_time)
  end

  def update_params
    params.permit(:name, :description, :start_date, :end_date, :story_point,
    :sprint_id, :feature_id, :estimate_time, :actual_time, :assignee_id)
  end
end
