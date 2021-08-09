class Forecast
  attr_reader :id, :hourly_weather, :daily_weather, :current_weather

  def initialize(data)
    @id = nil
    @current_weather = filter_current(data[:current])
    @hourly_weather = filter_hourly(data[:hourly])
    @daily_weather = filter_daily(data[:daily])
  end

  def filter_current(data)
    {datetime: Time.at(data[:dt]),
      sunrise: Time.at(data[:sunrise]),
      sunset: Time.at(data[:sunset]),
      temperature: data[:temp],
      feels_like: data[:feels_like],
      humidity: data[:humidity],
      uvi: data[:uvi],
      visibility: data[:visibility],
      conditions: data[:weather][0][:description],
      icon: data[:weather][0][:icon]
    }
  end

  def filter_hourly(data, number_of_hours = 8)
    hourly_weather = data.first(number_of_hours).map do |hour|
      {time: Time.at(hour[:dt]),
      temperature: hour[:temp],
      conditions: hour[:weather][0][:description],
      icon: hour[:weather][0][:icon]}
    end
  end

  def filter_daily(data, number_of_days = 5)
    daily_weather = data.first(number_of_days).map do |day|
      {date: Time.at(day[:dt]),
      sunrise: Time.at(day[:sunrise]),
      sunset: Time.at(day[:sunset]),
      max_temp: day[:temp][:max],
      min_temp: day[:temp][:min],
      conditions: day[:weather][0][:description],
      icon: day[:weather][0][:icon]}
    end
  end
end
