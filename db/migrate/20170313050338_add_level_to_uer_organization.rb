class AddLevelToUerOrganization < ActiveRecord::Migration
  def change
    add_column :user_organizations, :permission_level, :integer
  end
end
