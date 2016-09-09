class Station < ActiveRecord::Base
  validates :station_id, uniqueness: true
end
