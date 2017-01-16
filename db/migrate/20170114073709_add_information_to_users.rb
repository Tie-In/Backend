class AddInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string, null: false
    add_column :users, :lastname, :string, null: false
    add_column :users, :birth_date, :date
    add_column :users, :phone_number, :string, null: false
  end
end
