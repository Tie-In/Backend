class Tag < ActiveRecord::Base
  belongs_to :project

  has_many :task_tags, :dependent => :destroy
  has_many :tasks, :through => :task_tags
end
