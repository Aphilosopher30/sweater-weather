class BreweriesFacade
  def self.local_listing(city_state, limit = 100 )
    breweries_raw = BreweriesService.search_list(city_state).first(limit)
    breweries = breweries_raw.map do |brewery|
      Brewery.new(brewery)
    end
  end
end
