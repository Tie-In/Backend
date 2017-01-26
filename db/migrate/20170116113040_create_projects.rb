class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :description, default: ""
      t.integer :sprint_duration
      t.references :organization, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :status, default: :start

      t.timestamps null: false
    end
  end
end
