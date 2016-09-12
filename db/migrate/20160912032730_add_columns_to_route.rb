class AddColumnsToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :source, :string
    add_column :routes, :dest, :string
  end
end
