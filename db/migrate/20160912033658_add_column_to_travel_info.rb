class AddColumnToTravelInfo < ActiveRecord::Migration
  def change
    add_column :travel_infos, :late_by, :integer
  end
end
