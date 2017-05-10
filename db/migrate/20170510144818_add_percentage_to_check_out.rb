class AddPercentageToCheckOut < ActiveRecord::Migration[5.0]
  def change
    add_column :check_outs, :percentage, :integer, default: 100
  end
end
