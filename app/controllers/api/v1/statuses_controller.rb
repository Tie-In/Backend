class Api::V1::StatusesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
	respond_to :json

  def create
     status = Status.new(status_params)
    if status.save
      render json: status, status: 200
    else
      render json: { errors: status.errors }, status: 422
    end
  end

  private
  def sprint_params
    params.require(:status).permit(:name, :project_id)
  end
end
