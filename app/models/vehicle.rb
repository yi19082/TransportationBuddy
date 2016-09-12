class Vehicle < ActiveRecord::Base
  belongs_to :route
  has_many :travel_infos
end
