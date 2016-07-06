class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :context_id
      t.string :context_type
      t.references :person
      t.string :title

      t.timestamps null: false
    end
  end
end
