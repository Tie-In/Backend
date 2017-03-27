class UserOrganization < ActiveRecord::Base
  enum permission_level: [:user, :admin, :owner]

  belongs_to :user
  belongs_to :organization
end
