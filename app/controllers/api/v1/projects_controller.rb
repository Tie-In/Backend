class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :create]
	respond_to :json

  def show
    project = Project.find(params[:id])
    if project.users.include?(current_user)
      respond_with project, include: [:features, :effort_estimation]
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  def create
    project = Project.new(project_params)
    if project.save
      params[:project][:users].each do |contributor|
        user = User.find(contributor[:id])
        temp = ProjectContribute.new(user: user, project: project, permission_level: :user)
        temp.save
      end
      admin = ProjectContribute.new(user: current_user, project: project, permission_level: :admin)
      admin.save
      status_names = ['To do', 'Doing', 'Done']
      status_names.each do |name|
        status = Status.create(name: name, project: project)
      end
      render json: project, status: 200
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  private
  def project_params
    params.require(:project)
      .permit(:name, :organization_id, :description)
  end
end
