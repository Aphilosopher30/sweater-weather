class BreweriesFacade
  def self.local_listing(city_state, limit = 100 )
    breweries_raw = BreweriesService.search_list(city_state).first(limit.to_i)
    breweries = breweries_raw.map do |brewery|
      Brewery.new(brewery)
    end
  end

  def self.location_breweries(city_state, weather, limit = 100)
    breweries = BreweriesFacade.local_listing(city_state, limit)
    # binding.pry
    forecast = {sumary: weather[:conditions],
              temperature: weather[:temperature]}

    hash = {destination: city_state,
            forecast: forecast,
            breweries: breweries
          }

    location = Location.new(hash)
  end

end
