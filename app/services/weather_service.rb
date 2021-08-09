class WeatherService

  def self.connection
    Faraday.new(url: 'https://api.openweathermap.org') do |faraday|
      faraday.params['appid'] = ENV['weather_key']
    end
  end

  def self.parse_json(resp)
    JSON.parse(resp.body, symbolize_names: true)
  end

  def self.get_weather(coordinates)
    response = connection.get('/data/2.5/onecall') do |faraday|
      faraday.params[:lat] = coordinates[:lat]
      faraday.params[:lon] = coordinates[:lng]
      faraday.params[:exclude] = 'minutely,alerts'
    end
    parse_json(response)
  end
end
