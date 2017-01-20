class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name, null: false
      t.string :description, default: ""
      t.references :project, index: true, foreign_key: true
      t.timestamps null: false
    end
    change_table :projects do |t|
      t.references :feature, index: true, foreign_key: true
    end
  end
end
