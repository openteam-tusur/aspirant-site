class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.string :science_degree
      t.references :council_speciality, index: true, foreign_key: true
      t.references :dissertation_council, index: true, foreign_key: true
      t.date :placement_date
      t.string :place
      t.date :publication_date
      t.integer :applicant_id
      t.integer :mentor_id

      t.timestamps null: false
    end
  end
end
