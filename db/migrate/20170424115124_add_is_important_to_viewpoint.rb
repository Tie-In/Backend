class AddIsImportantToViewpoint < ActiveRecord::Migration
  def change
    add_column :viewpoints, :is_important, :bool, default: false
  end
end
