class AddDoneToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :is_done, :bool, default: false
    add_column :tasks, :done_date, :date
  end
end
