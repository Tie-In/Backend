class AddRelatedRetrospectiveColumn < ActiveRecord::Migration
  def change
    add_reference :viewpoints, :viewpoint_categories, index: true
  end
end
