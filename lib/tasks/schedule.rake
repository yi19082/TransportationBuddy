namespace :septa_buses_and_trolleys do
  desc "update real time data"
  task :update_real_time => :environment do
    response = RestClient.get('http://www3.septa.org/hackathon/TransitViewAll/')  
    result = JSON.parse(response.body)
    result.first.last.each do |vehicle_data|
      vehicle_data.each do |route_number, real_time_data|
      	real_time_data.each do |datum|
          route = Route.where(number: route_number).first_or_create
      	  vehicle = Vehicle.where(vehicle_id: datum['VehicleID'], route_id: route.id).first_or_create
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


namespace :septa_regional_rails do
  desc "update regional rails real time data"
  task :update_real_time => :environment do
    response = RestClient.get('http://www3.septa.org/hackathon/TrainView/')  
    result = JSON.parse(response.body)
    result.each do |data|
      route = Route.where(source: data['SOURCE'], dest: data['dest']).first_or_create
      vehicle = Vehicle.where(vehicle_id: data['trainno'], route_id: route.id).first_or_create
      travel_info = vehicle.travel_infos.new
      travel_info['lat'] = data['lat']
      travel_info['lng'] = data['lon']
      travel_info['next_stop'] = data['nextstop']
      travel_info['late_by'] = data['late']
      travel_info['track'] = data['TRACK']
      travel_info['track_change'] = data['TRACK_CHANGE']
      travel_info.save
    end
  end
end