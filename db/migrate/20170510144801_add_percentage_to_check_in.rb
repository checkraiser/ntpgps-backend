class AddPercentageToCheckIn < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :percentage, :integer, default: 100
  end
end
