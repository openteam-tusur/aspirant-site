class CreateCouncilSpecialities < ActiveRecord::Migration
  def change
    create_table :council_specialities do |t|
      t.string :code
      t.string :title
      t.string :science_type

      t.timestamps null: false
    end

    create_table :council_specialities_dissertation_councils do |t|
      t.references :dissertation_council
      t.references :council_speciality
    end
  end
end
