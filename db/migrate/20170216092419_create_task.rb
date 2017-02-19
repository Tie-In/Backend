class CreateTask < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.date :start_date
      t.date :end_date
      t.integer :story_point
      t.references :sprint, index: true, foreign_key: true
      t.references :feature, index: true, foreign_key: true
      t.decimal :estimate_time
      t.decimal :actual_time

      t.timestamps null: false
    end
  end
end
