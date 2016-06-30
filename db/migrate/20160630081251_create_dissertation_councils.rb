class CreateDissertationCouncils < ActiveRecord::Migration
  def change
    create_table :dissertation_councils do |t|
      t.string :number

      t.timestamps null: false
    end
  end
end
