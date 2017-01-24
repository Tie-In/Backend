class CreateTechnicalFactors < ActiveRecord::Migration
  def change
    create_table :technical_factors do |t|
      t.references :effort_estimation, index: true, foreign_key: true
      t.integer :rating_factor1
      t.integer :rating_factor2
      t.integer :rating_factor3
      t.integer :rating_factor4
      t.integer :rating_factor5
      t.integer :rating_factor6
      t.integer :rating_factor7
      t.integer :rating_factor8
      t.integer :rating_factor9
      t.integer :rating_factor10
      t.integer :rating_factor11
      t.integer :rating_factor12
      t.integer :rating_factor13
      t.decimal :t_factor

      t.timestamps null: false
    end
    change_table :projects do |t|
      t.references :technical_factor, index: true, foreign_key: true
    end
  end
end
