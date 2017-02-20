class CreateTaskTag < ActiveRecord::Migration
  def change
    create_table :task_tags do |t|
      t.references :task, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
