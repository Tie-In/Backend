class Api::V1::FeaturesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
	respond_to :json

  def create
    project = Project.find(features_params[:project_id])
    binding.pry
    features_params[:features].each do |feature|
      binding.pry
      temp = Feature.new(feature)
      temp.project = project
      temp.save
    end
    render json: project.features, status: 200
  end

  private
  def features_params
    params.require(:features).permit(:project_id, :features => [:name, :complexity])
  end
end
