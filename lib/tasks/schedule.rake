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

  desc "get latest stations"
  task :update_stations => :environment do
    require 'csv'
    response = RestClient.get('http://www3.septa.org/hackathon/Arrivals/station_id_name.csv')
    response = CSV.parse(response.body)
    response.shift
    response.each do |id, name|
      Station.create(station_id: id, station_name: name)
    end

  end

  task :update_station_location => :environment do
    Station.all.each do |station|
      print "#{station.station_name}\n"
      s_name = if station.station_name.include?('station')
                 station.station_name + " PA"
               else
                 station.station_name + " station PA"
               end

      # print "http://maps.googleapis.com/maps/api/geocode/json?address=#{s_name}\n"
      response = RestClient.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{s_name}")
      response = JSON.parse(response.body)
      # binding.pry

      station.update(full_address: response.try(:[], 'results').try(:[], 0).try(:[], 'formatted_address'),
                     lat: response.try(:[], 'results').try(:[], 0).try(:[], 'geometry').try(:[], 'location').try(:[], 'lat'),
                     lon: response.try(:[], 'results').try(:[], 0).try(:[], 'geometry').try(:[], 'location').try(:[], 'lng'))
      sleep(1)

    end
  end
end