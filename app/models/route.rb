class Route < ActiveRecord::Base
  has_many :vehicles

  def self.regional_rails
  	where.not(source: nil, dest: nil)
  end

  def self.buses_and_trolleys
  	where.not(number: nil)
  end
end
