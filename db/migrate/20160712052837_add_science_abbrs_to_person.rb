class AddScienceAbbrsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :science_degree_abbr, :string
    add_column :people, :science_title_abbr, :string
  end
end
