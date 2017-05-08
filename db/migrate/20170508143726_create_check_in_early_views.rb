class CreateCheckInEarlyViews < ActiveRecord::Migration
  def change
    create_view :check_in_early_views, materialized: true
  end
end
