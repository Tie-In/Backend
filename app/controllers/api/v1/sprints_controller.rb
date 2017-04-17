class Api::V1::SprintsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :show]
	respond_to :json

  def create
    sprint = Sprint.new(create_params)
    sprint.update(start_date: Date.today, number: sprint.project.sprints.size + 1)
    if sprint.save
      project = sprint.project
      project.current_sprint_id = sprint.id
      project.save
      params[:tasks].each do |task|
        temp = Task.find(task[:id])
        # check task not in any sprint
        if temp.sprint.nil?
          temp.sprint = sprint
          temp.story_point = task[:story_point]
          temp.status = sprint.project.statuses.first
          temp.save
        end
      end
      render json: sprint, status: 201
    else
      sprint.destroy
      render json: { errors: sprint.errors }, status: 422
    end
  end

  def show
    sprint = Sprint.find(params[:id])
    if sprint.project.users.include?(current_user)
      statuses = sprint.project.statuses
      temp_statuses = statuses
      statuses.each_with_index do |status, index| 
        temp_statuses[index].tasks = status.tasks.where(sprint_id: params[:id])
      end
      respond_to do |format|
        format.json { render :json => { :sprint => sprint.as_json,
                                        :statuses => temp_statuses.as_json(include: { tasks: { include: [:tags, :feature, :user] }}) }}
      end
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  def update
    sprint = Sprint.find(params[:id])
    if sprint.update(update_params)
      if sprint.is_ended
        sprint.update(end_date: Date.today)
        project = Project.find(sprint.project_id)
        project.update(current_sprint_id: nil)
        done_status = project.statuses.find_by(name: "Done").id
        undone_tasks = sprint.tasks.where(project: sprint.project_id).where.not(status_id: done_status)
        undone_tasks.each do |task|
          task.update(sprint: nil, status: nil, row_index: nil)
        end
        
      end
      render json: sprint, status: 200
    else
      render json: { errors: sprint.errors }, status: 422
    end
  end

  private
  def create_params
    params.require(:sprint).permit(:project_id, :sprint_points)
  end

  def update_params
    params.require(:sprint).permit(:is_ended)
  end
end
