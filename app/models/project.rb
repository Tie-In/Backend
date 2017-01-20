class Project < ActiveRecord::Base
  belongs_to :organization

  has_many :project_contributes, :dependent => :destroy
  has_many :users, :through => :project_contributes

  has_many :features
end
