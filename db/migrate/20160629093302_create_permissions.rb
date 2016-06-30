class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :user_id
      t.integer :context_id
      t.string :context_type
      t.string :role

      t.timestamps null: false
    end
  end
end
