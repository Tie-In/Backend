class AddStatusToTask < ActiveRecord::Migration
  def change
    add_reference :tasks, :status, index: true
    add_column :tasks, :row_index, :integer

    add_column :statuses, :column_index, :integer
  end
end
