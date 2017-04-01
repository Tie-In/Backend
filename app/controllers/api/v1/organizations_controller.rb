class Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :create, :update]
	respond_to :json

  def show
    org = Organization.find(params[:id])
    if org.users.include?(current_user)
      render json: org, include: { projects: { include: [ users: { except: :auth_token } ] }, user_organizations: { include: [ user: { except: :auth_token }]} }
    else
      render json: { errors: 'Permission denied' }, status: 401
    end
  end

  def update
    org = Organization.find(params[:id])
    if org.update(update_params)
      render json: org, status: 200
    else
      render json: { errors: org.errors }, status: 422
    end
  end

  def create
    organization = Organization.new(organization_params)
    if organization.save
      temp = UserOrganization.new(user: current_user, organization: organization, permission_level: :owner)
      if temp.save
        unless params[:organization][:users].nil?
          params[:organization][:users].each do |user|
            c = User.find(user[:id])
            UserOrganization.create(user: c, organization: organization, permission_level: :user)
          end
        end
        render :json => {:organization => organization.as_json(include: :projects),
                          :user => current_user.as_json(include: :organizations) }, status: 201
      else
        organization.destroy
        render json: { errors: "Owner cannot create the organization"}, status: 422
      end
    else
      render json: { errors: organization.errors }, status: 422
    end
  end

  private
  def organization_params
    params.require(:organization).permit(:name, :description)
  end

  def update_params
    params.require(:organization).permit(:name, :description)
  end
end
