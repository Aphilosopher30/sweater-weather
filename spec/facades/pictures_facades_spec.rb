require 'rails_helper'

RSpec.describe PicturesFacade do

  describe "pictures" do
    it "it makes one pict " do

      picture_api = File.read('spec/fixtures/unsplash/denver_co.json')

      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['photo_key']}&query=denver,co").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v1.6.0'
        }).
      to_return(status: 200, body: picture_api, headers: {})


        test = PicturesFacade.city_picture('denver,co')

        expect(test.class).to eq(Picture)
        expect(test.image_url).to_not eq(nil)
        expect(test.credits).to_not eq(nil)
    end
  end

end
