class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :vehicle_number
      t.integer :label
      t.integer :vehicle_id
      t.integer :block_id

      t.timestamps null: false
    end
  end
end
