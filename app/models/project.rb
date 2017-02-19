class Project < ActiveRecord::Base
  belongs_to :organization

  has_many :project_contributes, :dependent => :destroy
  has_many :users, :through => :project_contributes

  has_many :features

  has_one :effort_estimation

  has_many :sprints
  has_many :tasks
end
