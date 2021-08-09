class BreweriesService

  def self.connection
    Faraday.new(url: 'https://api.openbrewerydb.org')
  end

  def self.parse_json(resp)
    JSON.parse(resp.body, symbolize_names: true)
  end

  def self.search_list(city_state)
    response = connection.get('/breweries') do |faraday|
      faraday.params[:by_city_state] = city_state
    end
    parse_json(response)
  end
end
