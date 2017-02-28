class Status < ActiveRecord::Base
  has_many :tasks
  belongs_to :project

  default_scope { order(column_index: :asc) }
end
