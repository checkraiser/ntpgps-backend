class DropCheckOutLateViews < ActiveRecord::Migration[5.0]
  def change
    execute 'DROP MATERIALIZED VIEW check_out_late_views'
  end
end
