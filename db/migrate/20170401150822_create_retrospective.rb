class CreateRetrospective < ActiveRecord::Migration
  def change
    create_table :retrospectives do |t|
      t.integer :number
      t.references :sprint, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
    end
  end
end
