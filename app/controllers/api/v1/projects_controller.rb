class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :create, :update]
	respond_to :json

  def show
    project = Project.find(params[:id])
    if project.users.include?(current_user)
      render json: project, include: [:features, :effort_estimation, :users, project_contributes: { include: [ user: { except: :auth_token }]}]
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  def update
    project = Project.find(params[:id])
    if project.update(update_params)
      render json: project, status: 200
    else
      render json: { errors: project.errors }, status: 422
    end
  end


  def create
    project = Project.new(project_params)
    unless project.organization.projects.pluck(:name).include?(project.name)
      if project.save
        unless params[:project][:users].nil?
          params[:project][:users].each do |contributor|
            user = User.find(contributor[:id])
            temp = ProjectContribute.new(user: user, project: project, permission_level: :user)
            temp.save
          end
        end
        admin = ProjectContribute.new(user: current_user, project: project, permission_level: :admin)
        admin.save
        status_names = ['To do', 'Doing', 'Done']
        status_names.each_with_index do |name, i|
          status = Status.create(name: name, project: project, column_index: i)
        end
        render json: project, status: 200
      else
        render json: { errors: project.errors }, status: 422
      end
    else
      render json: { errors: { name: "Name is already taken" }}, status: 422
    end
  end

  private
  def project_params
    params.require(:project)
      .permit(:name, :organization_id, :description, :sprint_duration)
  end

  def update_params
    params.require(:project).permit(:name, :description)
  end
end
