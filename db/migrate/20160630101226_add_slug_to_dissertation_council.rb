class AddSlugToDissertationCouncil < ActiveRecord::Migration
  def change
    add_column :dissertation_councils, :slug, :string
    add_index :dissertation_councils, :slug, unique: true
    DissertationCouncil.find_each(&:save)
  end
end
