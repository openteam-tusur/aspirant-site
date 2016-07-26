class RemoveColumnCouncilSpecialityIdFromPerson < ActiveRecord::Migration
  def up
    remove_column :people, :council_speciality_id
  end

  def down
    add_column :people, :council_speciality_id, :integer
  end
end
