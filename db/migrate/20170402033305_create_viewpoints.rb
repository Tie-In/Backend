class CreateViewpoints < ActiveRecord::Migration
  def change
    create_table :viewpoints do |t|
      t.string :comment
      t.references :retrospective, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :type
      t.boolean :selected

      t.timestamps null: false
    end
  end
end
