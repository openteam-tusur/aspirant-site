class AddOrganizationNameToAdvert < ActiveRecord::Migration
  def change
    add_column :adverts, :organization_name, :string
  end
end
