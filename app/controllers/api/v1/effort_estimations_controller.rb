class Api::V1::EffotEstimationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
	respond_to :json

  def create
    project = Project.find(features_params[:project_id])
    temp = EffotEstimation.new
    features_params[:features].each do |feature|
      temp = Feature.new(feature)
      temp.project = project
      temp.save
    end
    render json: project.features, status: 200
  end

  private
  def effort_estimations_params
    params.require(:effort_estimations)
      .permit(:project_id, :technicals, :environmental, :uucp)
  end
end
