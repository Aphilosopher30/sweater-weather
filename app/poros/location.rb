class Location
  attr_reader :id, :destination, :forecast, :breweries

  def initialize(data)
    @id = nil
    @destination = data[:destination]
    @forecast = data[:forecast]
    @breweries= data[:breweries]
  end
end
