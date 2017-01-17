class CreateOrganization < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :description, default: ""
      t.references :owner, references: :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
