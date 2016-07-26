class AddCouncilSpecialityReferenceToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :council_speciality, index: true, foreign_key: true
  end
end
