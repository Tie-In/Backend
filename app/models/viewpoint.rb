class Viewpoint < ActiveRecord::Base
    enum kind: [:good, :bad, :try]

    belongs_to :retrospective
    belongs_to :user
    belongs_to :viewpoint_categories
end
