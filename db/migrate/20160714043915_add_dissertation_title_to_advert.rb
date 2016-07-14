class AddDissertationTitleToAdvert < ActiveRecord::Migration
  def change
    add_column :adverts, :title, :text
  end
end
