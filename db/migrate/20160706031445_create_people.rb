class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :url
      t.string :science_degree
      t.string :science_title
      t.references :council_speciality

      t.timestamps null: false
    end
  end
end
