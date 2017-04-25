class CreateRetrospectiveContribute < ActiveRecord::Migration
  def change
    create_table :retrospective_contributes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :retrospective, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
