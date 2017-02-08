class AddDevelopersToEffortEstimations < ActiveRecord::Migration
  def change
    add_column :effort_estimations, :developers, :integer
    add_column :effort_estimations, :lower_weeks, :decimal
    add_column :effort_estimations, :upper_weeks, :decimal
  end
end
