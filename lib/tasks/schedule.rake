namespace :septa do
  desc "update real time data"
  task :update_real_time => :environment do
    response = RestClient.get('http://www3.septa.org/hackathon/TransitViewAll/')  
    result = JSON.parse(response.body)
    result.first.last.each do |vehicle_data|
      vehicle_data.each do |vehicle_number, real_time_data|
      	real_time_data.each do |datum|
      	  vehicle = Vehicle.where(vehicle_number: vehicle_number, vehicle_id: datum['VehicleID']).first_or_create
      	  travel_info = vehicle.travel_infos.new
      	  travel_info['lat'] = datum['lat']
      	  travel_info['lng'] = datum['lng']
      	  travel_info['direction'] = datum['Direction']
      	  travel_info['destination'] = datum['destination']
      	  travel_info['offset'] = datum['Offset']
      	  travel_info['offset_sec'] = datum['Offset_sec']
      	  travel_info.save
      	end
      end
    end
  end
end