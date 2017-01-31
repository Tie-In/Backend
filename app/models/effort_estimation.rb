class EffortEstimation < ActiveRecord::Base
  has_one :environmental_factor
  has_one :technical_factor

  belongs_to :project
end
