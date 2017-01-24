class CreateEffortEstimations < ActiveRecord::Migration
  def change
    create_table :effort_estimations do |t|
      t.references :project, index: true, foreign_key: true
      t.decimal :t_factor
      t.decimal :e_factor
      t.decimal :uucp
      t.decimal :use_case_point

      t.timestamps null: false
    end
  end
end
