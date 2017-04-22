class Api::V1::EffortEstimationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :create]
	respond_to :json

  def create
    project = Project.find(effort_estimations_params[:project_id])
    effort = EffortEstimation.new(effort_estimations_params)
    tcf = 0.6 + ( 0.1 * effort[:t_factor])
    ecf = 1.4 + ( -0.03 * effort[:e_factor])
    ucp = effort[:uucp] * tcf * ecf
    effort[:use_case_point] = ucp
    hour_per_week_per_person = 30
    lower_hour_per_usecase = 20
    upper_hour_per_usecase = 28
    hour_per_week = hour_per_week_per_person * effort[:developers]
    weeks = [(ucp * lower_hour_per_usecase) / hour_per_week, (ucp * upper_hour_per_usecase) / hour_per_week]
    effort[:lower_weeks] = weeks[0]
    effort[:upper_weeks] = weeks[1]
    if effort.save
      project.effort_estimation_id = effort.id
      project.save
      features_params[:features].each do |feature|
        temp = Feature.new(feature)
        temp.project = project
        temp.save
      end
      technical = TechnicalFactor.new(technicals_params)
      technical.effort_estimation = effort
      technical[:t_factor] = effort[:t_factor]
      technical.save
      environmental = EnvironmentalFactor.new(environmentals_params)
      environmental.effort_estimation = effort
      environmental[:e_factor] = effort[:e_factor]
      environmental.save
      render json: effort, status: 200
    else
      render json: { errors: effort.errors }, status: 422
    end
  end

  def show
    estimation = EffortEstimation.find(params[:id])
    if estimation.project.users.include?(current_user)
      respond_to do |format|
        format.json  { render :json => {:effort_estimation => estimation.as_json,
                                        :technical_factor => estimation.technical_factor.as_json,
                                        :environmental_factor => estimation.environmental_factor.as_json,
                                        :features => estimation.project.features.as_json }}
      end
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  private
  def effort_estimations_params
    params.require(:effort_estimations)
      .permit(:project_id, :t_factor, :e_factor, :uucp, :developers)
  end

  def features_params
    params.permit(:features => [:name, :complexity])
  end

  def technicals_params
    params.require(:technicals).permit!
  end

  def environmentals_params
    params.require(:environmentals).permit!
  end
end
