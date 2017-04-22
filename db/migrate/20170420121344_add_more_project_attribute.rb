class AddMoreProjectAttribute < ActiveRecord::Migration
  def change
    add_column :projects, :max_sprint_point, :integer 
    add_column :projects, :max_story_point, :integer
    add_reference :projects, :effort_estimation, index: true

    remove_column :sprints, :maximum_points
  end
end
