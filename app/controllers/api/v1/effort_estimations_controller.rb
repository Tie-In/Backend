class Api::V1::EffortEstimationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
	respond_to :json

  def create
    project = Project.find(effort_estimations_params[:project_id])
    effort = EffortEstimation.new(effort_estimations_params)
    tcf = 0.6 + ( 0.1 * effort[:t_factor])
    ecf = 1.4 + ( -0.03 * effort[:e_factor])
    ucp = effort[:uucp] * tcf * ecf
    effort[:use_case_point] = ucp
    if effort.save
      # features_params[:features].each do |feature|
      #   binding.pry
      #   temp = Feature.new(feature)
      #   temp.project = project
      #   temp.save
      # end
      technical = TechnicalFactor.new(technicals_params[:technicals], effort_estimation: effort)
      technical[:t_factor] = effort[:t_factor]
      technical.save
      environmental = EnvironmentalFactor.new(environmentals_params[:environmentals], effort_estimation: effort)
      environmental[:e_factor] = effort[:e_factor]
      environmental.save
      render json: effort, status: 200
    else
      render json: { errors: effort.errors }, status: 422
    end
  end

  private
  def effort_estimations_params
    params.require(:effort_estimations)
      .permit(:project_id, :t_factor, :e_factor, :uucp)
  end

  def features_params
    params.permit(:features => [:name, :complexity])
  end

  def technicals_params
    params.permit(:technicals)
  end

  def environmentals_params
    params.permit(:environmentals)
  end
end
