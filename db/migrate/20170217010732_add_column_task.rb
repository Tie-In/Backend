class AddColumnTask < ActiveRecord::Migration
  def change
    # assignee => user
    add_column :tasks, :assignee_id, :integer

    add_reference :tasks, :project, index: true
  end
end
