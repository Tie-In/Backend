class Sprint < ActiveRecord::Base
  belongs_to :project

  has_many :tasks
  has_one :retrospective

  default_scope { order(number: :asc) }
end
