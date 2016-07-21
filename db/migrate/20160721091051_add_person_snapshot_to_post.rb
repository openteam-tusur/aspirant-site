class AddPersonSnapshotToPost < ActiveRecord::Migration
  def change
    add_column :posts, :snapshot, :text
  end
end
