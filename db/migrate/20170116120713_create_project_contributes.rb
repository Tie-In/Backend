class CreateProjectContributes < ActiveRecord::Migration
  def change
    create_table :project_contributes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.integer :permission_level

      t.timestamps null: false
    end
  end
end
