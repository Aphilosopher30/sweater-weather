class BrewerySerializer
  include FastJsonapi::ObjectSerializer
  set_type :breweries
  attributes :destination, :forecast, :breweries
end
