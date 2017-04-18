class AddTimeLimitToRetrospective < ActiveRecord::Migration
  def change
    add_column :retrospectives, :time_limit, :string
  end
end
