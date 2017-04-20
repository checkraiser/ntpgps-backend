class AddAddressToCheckOut < ActiveRecord::Migration[5.0]
  def change
    add_column :check_outs, :address, :string
  end
end
