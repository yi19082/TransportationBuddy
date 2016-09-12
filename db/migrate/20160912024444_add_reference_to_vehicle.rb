class AddReferenceToVehicle < ActiveRecord::Migration
  def change
    add_reference :vehicles, :route, index: true
  end
end
