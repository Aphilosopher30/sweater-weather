class WeatherFacade

  def self.weather_data(long_and_lat)
    weather_data = WeatherService.get_weather(long_and_lat)
    data_object = Forecast.new(weather_data)
  end

  def self.weather_at_arrival(destination)
    weather_info = WeatherService.get_weather(destination[:coordinates])
    if destination[:time][:hours] == "impossible"
      arival_time = destination[:hours]
      {}
    elsif destination[:time][:hours] > 48
      # binding.pry
      arival_time = weather_info[:daily][(destination[:time][:hours]/24).round]
      {termperature: arival_time[:temp], weather: arival_time[:weather][0][:description]}
    else
      arival_time = weather_info[:hourly][destination[:time][:hours]]
      {termperature: arival_time[:temp], weather: arival_time[:weather][0][:description]}
    end
  end

end
