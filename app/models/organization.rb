class Organization < ActiveRecord::Base
  has_one: :user, foreign_key: 'owner_id'
end
