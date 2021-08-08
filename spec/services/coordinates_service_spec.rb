require 'rails_helper'

RSpec.describe CoordinatesService do

  describe "returns coordinates" do
    it "returns the desired coordinates" do




        coordinants = MapService.geo_coordinates('Denver,CO')
        expected = JSON.parse(json_response, symbolize_names: true)

        expect(coordinants).to eq(expected)

    end


    it "responds to non-existant city" do
    end
    it "responds to empoty string" do
    end
    it "" do
    end
  end

end
