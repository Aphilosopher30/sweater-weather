class MapFacade

  def self.get_coordinates(city_state)
    location_data = MapService.geo_coordinates(city_state)
    # if is_invalid?
    # else
      return location_data[:results].first[:locations][0][:displayLatLng]
    # end
  end

  # def is_invalid?
  #   response[:info][:messages][0] != nil || response[:info][:messages][0] == "Illegal argument from request: Insufficient info for location"
  # end

  def self.destination_info(start, destination)
    coordinates = get_coordinates(destination)
    time = rout_time_hours(start, destination)
    {time: time, coordinates: coordinates}
  end

  def self.rout_time_hours(start, destination)
    response = MapService.directions(start, destination)
    if MapFacade.route_is_possible?(response)
      return {hours: "impossible", formated_time: "impossible"}
    end
    MapFacade.format_time_info(response[:route])
  end

### helper methods
  def self.format_time_info(route)
    hours = calculate_hours(route)
    formated_time = route[:formattedTime]
    {hours: hours, formated_time: formated_time}
  end

  def self.route_is_possible?(response)
    response[:info][:messages][0] != nil || response[:info][:messages][0] == 'We are unable to route with the given locations.'
  end

  def self.calculate_hours(route)
    seconds = route[:realTime]
    if seconds == 10000000
      hours = route[:formattedTime].split(":").first.to_i
    else
      hours = (seconds/(60.0)**2).round
    end
    hours
  end
end
