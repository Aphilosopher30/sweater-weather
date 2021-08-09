class BreweriesFacade
  def self.local_listing(city_state, weather, limit = 100 )
    breweries_raw = BreweriesService.search_list(city_state).first(limit.to_i)
    # breweries = breweries_raw.map do |brewery|
    #   Brewery.new(brewery)
    # end
    {destination: city_state,
      forecast: {summary: weather[:conditions],
                temperature: weather[:temperature]
              },
      breweries: breweries_raw}
  end


end
