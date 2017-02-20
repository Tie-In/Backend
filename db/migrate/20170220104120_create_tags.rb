class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.references :project, index: true, foreign_key: true
      t.string :color_code
    end
  end
end
