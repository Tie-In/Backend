class AddEndSprintStatus < ActiveRecord::Migration
  def change
    add_column :sprints, :is_ended, :bool, default: false
  end
end
