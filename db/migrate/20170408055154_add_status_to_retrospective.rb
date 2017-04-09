class AddStatusToRetrospective < ActiveRecord::Migration
  def change
    add_column :retrospectives, :status, :integer
    add_column :retrospectives, :created_at, :datetime
    add_column :retrospectives, :updated_at, :datetime
  end
end
