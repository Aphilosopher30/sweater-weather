require 'rails_helper'

RSpec.describe BreweryService do

  describe "returns coordinates" do
    it "returns the desired coordinates" do


      breweries = BreweryService.search_list('Denver,CO')
      expected = JSON.parse(denver_beer, symbolize_names: true)

      expect(breweries).to eq(expected)
    end


    it "responds to non-existant city" do
    end
    it "responds to empoty string" do
    end
  end

end
