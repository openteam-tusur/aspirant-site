class AddPersonTypeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :person_type, :string
  end
end
