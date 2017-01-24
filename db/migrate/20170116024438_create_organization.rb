class CreateOrganization < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :description, default: ""

      t.timestamps null: false
    end
  end
end
