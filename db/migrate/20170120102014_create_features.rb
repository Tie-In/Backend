class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name, null: false
      t.string :description, default: ""
      t.integer :complexity
      t.references :project, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
