class RenameViewpointColumnType < ActiveRecord::Migration
  def change
    rename_column :viewpoints, :type, :kind
  end
end
