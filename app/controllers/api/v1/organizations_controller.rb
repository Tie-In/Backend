class Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
	respond_to :json

  def create
    organization = Organization.new(organization_params)
    if organization.save
      temp = UserOrganization.new(user: current_user, organization: organization)
      temp.save
      params[:organization][:users].each do |user|
        c = User.find(user[:id])
        UserOrganization.create(user: c, organization: organization)
      end
      render json: organization, include: [:projects], status: 200
    else
      render json: { errors: organization.errors }, status: 422
    end
  end

  private
  def organization_params
    binding.pry
    params.require(:organization).permit(:name, :description)
  end
end
