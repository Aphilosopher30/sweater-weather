class MapFacade

  def self.get_coordinates(city_state)
    location_data = MapService.geo_coordinates(city_state)
    coordinates = location_data[:results].first[:locations][0][:displayLatLng]
  end


end
