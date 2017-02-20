class Task < ActiveRecord::Base
  belongs_to :feature
  belongs_to :sprint
  belongs_to :project
  belongs_to :user, :foreign_key => 'assignee_id'
  belongs_to :statuses

  has_many :task_tags, :dependent => :destroy
  has_many :tasks, :through => :task_tags
end
