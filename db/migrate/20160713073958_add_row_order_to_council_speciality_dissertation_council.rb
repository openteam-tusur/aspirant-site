class AddRowOrderToCouncilSpecialityDissertationCouncil < ActiveRecord::Migration
  def change
    add_column :council_specialities_dissertation_councils, :row_order, :integer
  end
end
