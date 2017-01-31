class Api::V1::FeaturesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
	respond_to :json

  # planning features
  def create
    project = Project.find(features_params[:project_id])
    project.features.destroy_all
    features_params[:features].each do |feature|
      temp = Feature.new(feature)
      temp.project = project
      temp.save
    end
    render json: project, include: [:features], status: 200
  end

  private
  def features_params
    params.require(:features).permit(:project_id, :features => [:name, :complexity])
  end
end
