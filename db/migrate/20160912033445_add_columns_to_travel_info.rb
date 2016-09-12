class AddColumnsToTravelInfo < ActiveRecord::Migration
  def change
    add_column :travel_infos, :service, :string
    add_column :travel_infos, :track, :string
    add_column :travel_infos, :track_change, :string
    add_column :travel_infos, :next_stop, :string
  end
end
