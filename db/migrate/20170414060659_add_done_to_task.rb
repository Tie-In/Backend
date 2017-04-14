class AddDoneToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :is_done, :bool, default: false
  end
end
