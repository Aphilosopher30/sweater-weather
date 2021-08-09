class BrewerySerializer
  include FastJsonapi::ObjectSerializer
  set_type :brewery
  attributes :destination, :forecast, :breweries

end
