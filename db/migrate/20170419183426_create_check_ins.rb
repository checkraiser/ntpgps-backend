class CreateCheckIns < ActiveRecord::Migration[5.0]
  def change
    create_table :check_ins do |t|
      t.references :user, foreign_key: true
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
