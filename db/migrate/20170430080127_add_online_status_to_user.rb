class AddOnlineStatusToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :online_status, :boolean, null: false, default: false, index: true
  end
end
