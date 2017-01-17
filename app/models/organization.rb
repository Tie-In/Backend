class Organization < ActiveRecord::Base
  has_one :user, foreign_key: 'owner_id'

  has_many :user_organizations, :dependent => :destroy
  has_many :users, :through => :user_organizations

  has_many :projects
end
