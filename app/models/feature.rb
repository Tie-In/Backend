class Feature < ActiveRecord::Base
  enum complexity: [:simple, :medium, :complex]

  belongs_to :project
end
