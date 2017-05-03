class AddPercentageToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :percentage, :integer, null: false, default: 100
  end
end
