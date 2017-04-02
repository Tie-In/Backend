class ViewpointCategory < ActiveRecord::Base
    belongs_to :retrospective
    has_many :categories
end
