class CreateIndexForHistoryCheckInOuts < ActiveRecord::Migration[5.0]
  def change
    add_index :history_check_in_out_views, [:user_id, :check_in_created_at, :check_out_created_at], unique: true, name: :hciov_idx
  end
end
