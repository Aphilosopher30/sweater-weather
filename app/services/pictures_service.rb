class PicturesService

  def self.connection
    Faraday.new(url: 'https://api.unsplash.com/') do |faraday|
      faraday.params['client_id'] = ENV['photo_key']
    end
  end

  def self.parse_json(resp)
    JSON.parse(resp.body, symbolize_names: true)
  end

  def self.city_picture(city_state)
    response = connection.get('/search/photos') do |faraday|
      faraday.params[:query] = city_state
    end
    parse_json(response)
  end

end
