class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :station_id
      t.string :station_name

      t.timestamps null: false
    end
  end
end
