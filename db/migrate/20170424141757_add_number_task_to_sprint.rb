class AddNumberTaskToSprint < ActiveRecord::Migration
  def change
    add_column :sprints, :postpone_count, :integer, default: 0
    add_column :sprints, :done_count, :integer, default: 0
  end
end
