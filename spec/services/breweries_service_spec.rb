require 'rails_helper'

RSpec.describe BreweriesService do

  describe "returns coordinates" do
    it "returns the desired coordinates" do

      denver_beer = File.read('spec/fixtures/open_brewery/denver_co.json')

      stub_request(:get, "https://api.openbrewerydb.org/breweries?by_city_state=Denver,CO").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: denver_beer, headers: {})


      breweries = BreweriesService.search_list('Denver,CO')
      expected = JSON.parse(denver_beer, symbolize_names: true)

      expect(breweries).to eq(expected)
    end
  end

end
