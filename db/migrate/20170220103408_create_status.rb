class CreateStatus < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.references :project, index: true, foreign_key: true
    end
  end
end
