class Viewpoint < ActiveRecord::Base
    belongs_to :retrospective
    belongs_to :user
    belongs_to :viewpoint_categories
end
