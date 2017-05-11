class CreateIndexForHistoryCheckInOuts < ActiveRecord::Migration[5.0]
  def change
    execute 'CREATE UNIQUE INDEX history_check_in_outs
  ON history_check_in_out_views (user_id, check_in_created_at,check_out_created_at);'
  end
end
