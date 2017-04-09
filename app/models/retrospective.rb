class Retrospective < ActiveRecord::Base
  enum status: [:in_progress, :categorise, :done]
  belongs_to :project
  belongs_to :sprint

  has_many :viewpoint
end
