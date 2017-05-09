class DropCheckInEarlyView < ActiveRecord::Migration[5.0]
  def change
    execute 'DROP MATERIALIZED VIEW check_in_early_views'
  end
end
