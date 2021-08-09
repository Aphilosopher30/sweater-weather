class WeatherFacade

  def self.weather_data(long_and_lat)
    weather_data = WeatherService.get_weather(long_and_lat)
    data_object = Forecast.new(weather_data)
  end
end
