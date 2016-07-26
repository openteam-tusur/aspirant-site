class AddAasmStateToAdvert < ActiveRecord::Migration
  def change
    add_column :adverts, :aasm_state, :string
  end
end
