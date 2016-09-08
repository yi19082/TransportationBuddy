class VehiclesController < ApplicationController
  
  def index
  	@vehicles = Vehicle.all
  end

  def show
  	@vehicle = Vehicle.find(params[:id])
  end

  def destroy

  end
end
