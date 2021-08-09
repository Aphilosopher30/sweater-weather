require 'rails_helper'

RSpec.describe BreweriesFacade do

  context ' location_listings' do
    it 'gives a list of Brewery objects' do

      denver_beer = File.read('spec/fixtures/open_brewery/denver_co.json')

      stub_request(:get, "https://api.openbrewerydb.org/breweries?by_city_state=Denver,CO").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: denver_beer, headers: {})


      test = BreweriesFacade.local_listing("Denver,CO")

      expect(test).to be_a(Array)
      expect(test.first.class).to eq(Brewery)
      expect(test.last.class).to eq(Brewery)
    end

    describe 'list length ' do
      it 'defaults to 100' do

        denver_beer = File.read('spec/fixtures/open_brewery/denver_co.json')

        stub_request(:get, "https://api.openbrewerydb.org/breweries?by_city_state=Denver,CO").
          with(
            headers: {
           'Accept'=>'*/*',
           'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           'User-Agent'=>'Faraday v1.6.0'
            }).
          to_return(status: 200, body: denver_beer, headers: {})

        test = BreweriesFacade.local_listing("Denver,CO")

        expect(test).to be_a(Array)
        expect(test.length).to eq(100)
      end
      it 'gives back the specified length if provided' do
        denver_beer = File.read('spec/fixtures/open_brewery/denver_co.json')

        stub_request(:get, "https://api.openbrewerydb.org/breweries?by_city_state=Denver,CO").
          with(
            headers: {
           'Accept'=>'*/*',
           'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           'User-Agent'=>'Faraday v1.6.0'
            }).
          to_return(status: 200, body: denver_beer, headers: {})


        test = BreweriesFacade.local_listing("Denver,CO")

        expect(test).to be_a(Array)
        expect(test.length).to eq(100)

      end
    end
  end
end
