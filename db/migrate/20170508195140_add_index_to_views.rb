class AddIndexToViews < ActiveRecord::Migration[5.0]
  def change
    add_index :check_in_day_views, [:user_id, :check_in_month, :check_in_day], unique: true, name: :cidv_idx
    add_index :check_in_late_views, [:user_id, :check_in_month, :check_in_date], unique: true, name: :cilv_idx
    add_index :check_out_day_views, [:user_id, :check_out_month, :check_out_day], unique: true, name: :codv_idx
    add_index :check_out_early_views, [:user_id, :check_out_month, :check_out_date], unique: true, name: :coev_idx
  end
end
