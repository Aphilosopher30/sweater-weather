class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_type :forecast
  attributes :hourly_weather, :daily_weather, :current_weather
end
