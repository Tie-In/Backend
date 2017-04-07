class Api::V1::SprintsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :show]
	respond_to :json

  def create
    sprint = Sprint.new(create_params)
    sprint.number = sprint.project.sprints.size + 1
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
      render json: sprint, status: 200
    else
      render json: { errors: sprint.errors }, status: 422
    end
  end

  def show
    sprint = Sprint.find(params[:id])
    if sprint.project.users.include?(current_user)
      statuses = sprint.project.statuses
      respond_to do |format|
        format.json { render :json => { :sprint => sprint.as_json,
                                        :statuses => statuses.as_json(include: { tasks: { include: [:tags, :feature] }}) }}
      end
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  private
  def create_params
    params.permit(:number, :project_id, :start_date, :end_date, :sprint_points)
  end
end
