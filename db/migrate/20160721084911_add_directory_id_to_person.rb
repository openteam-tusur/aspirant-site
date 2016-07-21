class AddDirectoryIdToPerson < ActiveRecord::Migration
  def change
    add_column :people, :directory_id, :integer
  end
end
