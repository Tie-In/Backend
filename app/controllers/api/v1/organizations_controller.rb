class Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
	respond_to :json

  def create
    organization = Organization.new(organization_params)
    organization.owner_id = current_user.id
    if organization.save
      temp = UserOrganization.new(user: current_user, organization: organization)
      if temp.save
        render json: organization, status: 200
      end
    else
      render json: { errors: organization.errors }, status: 422
    end
  end

  private
  def organization_params
    params.require(:organization).permit(:name)
  end
end
