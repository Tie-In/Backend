class Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :create]
	respond_to :json

  def show
    org = Organization.find(params[:id])
    if org.users.include?(current_user)
      respond_with org, include: [:projects]
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  def create
    organization = Organization.new(organization_params)
    if organization.save
      temp = UserOrganization.new(user: current_user, organization: organization)
      temp.save
      params[:organization][:users].each do |user|
        c = User.find(user[:id])
        UserOrganization.create(user: c, organization: organization)
      end
      # render json: organization, include: [:projects], status: 200
      respond_to do |format|
        format.json  { render :json => {:organization => organization.as_json(include: :projects),
                                        :user => current_user.as_json(include: :organizations) }}
      end
    else
      render json: { errors: organization.errors }, status: 422
    end
  end

  private
  def organization_params
    params.require(:organization).permit(:name, :description)
  end
end
