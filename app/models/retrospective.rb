class Retrospective < ActiveRecord::Base
  enum status: [:in_progress, :categorise, :done]
  belongs_to :project
  belongs_to :sprint

  has_many :viewpoints
  has_many :viewpoint_categories

  has_many :retrospective_contributes, :dependent => :destroy
  has_many :users, :through => :retrospective_contributes

end
