class AddFullAddressAndLatAndLonToStation < ActiveRecord::Migration
  def change
    add_column :stations, :full_address, :string
    add_column :stations, :lat, :float
    add_column :stations, :lon, :float
  end
end
