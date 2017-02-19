class CreateSprint < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.integer :number
      t.date :start_date
      t.date :end_date
      t.references :project, index: true, foreign_key: true
      t.integer :sprint_points
      t.integer :maximum_points

      t.timestamps null: false
    end
  end
end
