class CreateViewpointCategories < ActiveRecord::Migration
  def change
    create_table :viewpoint_categories do |t|
      t.string :name
      t.references :retrospective, index: true, foreign_key: true
      t.string :color
      
      t.timestamps null: false
    end
  end
end
