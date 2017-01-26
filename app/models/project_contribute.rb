class ProjectContribute < ActiveRecord::Base
  enum permission_level: [:user, :admin]

  belongs_to :project
  belongs_to :user
end
