class Task < ActiveRecord::Base
  belongs_to :feature
  belongs_to :sprint
  belongs_to :project
  belongs_to :user, :foreign_key => 'assignee_id'
end
