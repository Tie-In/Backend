class Sprint < ActiveRecord::Base
  belongs_to :project

  has_many :tasks
  has_one :retrospective
end
