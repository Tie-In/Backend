class Task < ActiveRecord::Base
  belongs_to :feature
  belongs_to :sprint
  belongs_to :project
  belongs_to :user, :foreign_key => 'assignee_id'
  belongs_to :status

  has_many :task_tags, :dependent => :destroy
  has_many :tags, :through => :task_tags

  default_scope { order(row_index: :asc, id: :asc) }
end
