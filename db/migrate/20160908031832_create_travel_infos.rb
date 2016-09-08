class CreateTravelInfos < ActiveRecord::Migration
  def change
    create_table :travel_infos do |t|
      t.string :direction
      t.string :destination
      t.float :lat
      t.float :lng
      t.integer :offset
      t.integer :offset_sec
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
