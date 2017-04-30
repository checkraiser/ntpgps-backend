class AddUpdateLocationAtToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :update_location_at, :datetime, null: false, index: true, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
