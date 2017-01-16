class CreateOrganization < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.references :owner, references: :user, index: true, foreign_key: true
    end
  end
end
