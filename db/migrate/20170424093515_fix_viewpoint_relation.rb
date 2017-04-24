class FixViewpointRelation < ActiveRecord::Migration
  def change
    remove_reference :viewpoints, :viewpoint_categories, index: true

    add_reference :viewpoints, :viewpoint_category, index: true  
  end
end
