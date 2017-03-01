class Api::V1::StatusesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
	respond_to :json

  def create
     status = Status.new(create_params)
    if status.save
      render json: status, include: { tasks: { include: :tags }}, status: 200
    else
      render json: { errors: status.errors }, status: 422
    end
  end

  def update
    current_status = Status.find(params[:id])
    unless params[:column_index].nil?
      new_index = params[:column_index]
      statuses = Project.find(current_status.project_id).statuses
      unless statuses.empty?
        statuses = statuses.sort_by { |t| t["column_index"]}
        statuses.delete_at(current_status.column_index)
        statuses.insert(params[:column_index].to_i, current_status)
      end
      statuses.each_with_index do |status, i|
        status.update(column_index: i)
      end
      render json: current_status, include: { tasks: { include: :tags }}, status: 200
    else
      if current_status.update(update_params)
        statuses = current_status.project.statuses
        # render all status in project (bad way)
        render json: statuses, include: { tasks: { include: [:tags, :feature] }}, status: 200
      else
        render json: { errors: current_status.errors }, status: 422
      end
    end
  end

  def destroy
    status = Status.find(params[:id]).destroy
    project = status.project
    if status.destroy
      # render all status in project (bad way)
      render json: project.statuses, include: { tasks: { include: [:tags, :feature] }}, status: 200
    else
      render json: { errors: status.errors }, status: 422
    end


  end

  private
  def create_params
    params.permit(:name, :project_id, :column_index)
  end

  def update_params
    params.permit(:name)
  end

end
