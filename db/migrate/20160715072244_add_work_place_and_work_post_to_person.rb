class AddWorkPlaceAndWorkPostToPerson < ActiveRecord::Migration
  def change
    add_column :people, :work_place, :text
    add_column :people, :work_post, :text
  end
end
