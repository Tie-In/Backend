class Api::V1::StatusesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
	respond_to :json

  def create
     status = Status.new(create_params)
     status.column_index = status.project.statuses.length
    if status.save
      render json: status, include: { tasks: { include: :tags }}, status: 201
    else
      render json: { errors: status.errors }, status: 422
    end
  end

  def update
    current_status = Status.find(params[:id])
    unless update_params[:column_index].nil?
      new_index = update_params[:column_index]
      statuses = Project.find(current_status.project_id).statuses
      unless statuses.empty?
        statuses = statuses.sort_by { |t| t["column_index"]}
        statuses.delete_at(current_status.column_index)
        statuses.insert(update_params[:column_index].to_i, current_status)
      end
      statuses.each_with_index do |status, i|
        status.update(column_index: i)
      end
    end
    if current_status.update(name: update_params[:name])
      statuses = current_status.project.statuses
      render json: status, include: { tasks: { include: :tags }}, status: 200
    else
      render json: { errors: current_status.errors }, status: 422
    end
  end

  def destroy
    status = Status.find(params[:id]).destroy
    first_status = status.project.statuses.first
    temp_index = first_status.tasks.length
    status.tasks.each_with_index do |task, i|
      task.update(status: first_status, row_index: temp_index + i)
    end
    if status.destroy
      render json: status, include: { tasks: { include: :tags }}, status: 200
    else
      render json: { errors: status.errors }, status: 422
    end


  end

  private
  def create_params
    params.require(:status).permit(:name, :project_id, :column_index)
  end

  def update_params
    params.require(:status).permit(:name, :column_index)
  end

end
