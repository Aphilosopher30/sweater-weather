class RoadTrip < ApplicationRecord

  validates :start_city, presence: true
  validates :end_city, presence: true

end
