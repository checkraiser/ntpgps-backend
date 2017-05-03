class AddPercentageToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :percentage, :integer, null: false, default: 100
  end
end
