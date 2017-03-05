class Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :create]
	respond_to :json

  def show
    org = Organization.find(params[:id])
    if org.users.include?(current_user)
      respond_with org, include: { projects: { include: [:users] }}
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  def create
    organization = Organization.new(organization_params)
    if organization.save
      temp = UserOrganization.new(user: current_user, organization: organization)
      if temp.save
        unless params[:organization][:users].nil?
          params[:organization][:users].each do |user|
            c = User.find(user[:id])
            UserOrganization.create(user: c, organization: organization)
          end
        end
        respond_to do |format|
          format.json  { render :json => {:organization => organization.as_json(include: :projects),
                                          :user => current_user.as_json(include: :organizations) }}
        end
      else
        organization.destroy
        render json: { errors: "Owner cannot be create the organization"}, status: 422
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
