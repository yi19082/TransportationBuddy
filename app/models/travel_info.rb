class TravelInfo < ActiveRecord::Base
  belongs_to :vehicle

  def coordinate
  	"(#{lat}, #{lng})"
  end
end
