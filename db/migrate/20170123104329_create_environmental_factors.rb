class CreateEnvironmentalFactors < ActiveRecord::Migration
  def change
    create_table :environmental_factors do |t|
      t.references :effort_estimation, index: true, foreign_key: true
      t.integer :rating_factor1
      t.integer :rating_factor2
      t.integer :rating_factor3
      t.integer :rating_factor4
      t.integer :rating_factor5
      t.integer :rating_factor6
      t.integer :rating_factor7
      t.integer :rating_factor8
      t.decimal :e_factor

      t.timestamps null: false
    end
    change_table :projects do |t|
      t.references :environmental_factor, index: true, foreign_key: true
    end
  end
end
