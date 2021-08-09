require 'rails_helper'

RSpec.describe BreweriesFacade do

  context ' location_listings' do
    it 'gives a list of Brewery objects' do

      test = BreweriesFacade.local_listing("Denver,CO")

      expect(test).to be_a(Array)
      expect(test.first.class).to eq(Brewery)
      expect(test.last.class).to eq(Brewery)
    end

    describe 'list length ' do
      it 'defaults to 100' do
        test = BreweriesFacade.local_listing("Denver,CO")

        expect(test).to be_a(Array)
        expect(test.length).to eq(100)
      end
      it 'gives back the specified length if provided' do

        test = BreweriesFacade.local_listing("Denver,CO")

        expect(test).to be_a(Array)
        expect(test.length).to eq(100)

      end
    end
  end
end
