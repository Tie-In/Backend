class ViewpointCategory < ActiveRecord::Base
    belongs_to :retrospective
    has_many :viewpoints
end
