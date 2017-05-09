class CreateCheckOutEarlyViews < ActiveRecord::Migration
  def change
    create_view :check_out_early_views, materialized: true
  end
end
