class AddPersonReferenceToFileCopy < ActiveRecord::Migration
  def change
    add_reference :file_copies, :person, index: true, foreign_key: true
  end
end
