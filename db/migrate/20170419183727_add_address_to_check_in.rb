class AddAddressToCheckIn < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :address, :string
  end
end
