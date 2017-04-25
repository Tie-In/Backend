class RetrospectiveContribute < ActiveRecord::Base
  belongs_to :retrospective
  belongs_to :user
end
