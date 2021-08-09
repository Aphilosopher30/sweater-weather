require 'rails_helper'

RSpec.describe BreweriesService do

  describe "returns coordinates" do
    it "returns the desired coordinates" do


      breweries = BreweriesService.search_list('Denver,CO')
      expected = JSON.parse(denver_beer, symbolize_names: true)

      expect(breweries).to eq(expected)
    end
  end

end
