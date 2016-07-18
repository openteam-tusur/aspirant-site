class CreateFileCopies < ActiveRecord::Migration
  def change
    create_table :file_copies do |t|
      t.attachment :file
      t.date :placement_date
      t.string :kind
      t.integer :context_id
      t.string :context_type
      t.timestamps null: false
    end
  end
end
