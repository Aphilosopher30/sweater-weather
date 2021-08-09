require 'rails_helper'

RSpec.describe Brewery do

  context 'the brewery class exists and has attributes' do
    it 'has atrributes' do
      data = {
          "id": 9094,
          "obdb_id": "bnaf-llc-austin",
          "name": "Bnaf, LLC",
          "brewery_type": "planning",
          "street": nil,
          "address_2": nil,
          "address_3": nil,
          "city": "Austin",
          "state": "Texas",
          "county_province": nil,
          "postal_code": "78727-7602",
          "country": "United States",
          "longitude": nil,
          "latitude": nil,
          "phone": nil,
          "website_url": nil,
          "updated_at": "2018-07-24T00:00:00.000Z",
          "created_at": "2018-07-24T00:00:00.000Z"
      }

      brewery = Brewery.new(data)

      expect(brewery.id).to eq(9094)
      expect(brewery.name).to eq('Bnaf, LLC')
      expect(brewery.brewery_type).to eq('planning')
    end
  end
end
