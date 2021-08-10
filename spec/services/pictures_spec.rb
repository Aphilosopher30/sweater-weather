require 'rails_helper'

RSpec.describe PicturesService do

  describe "returns picture " do
    it "returns the desired pict" do

      picture_api = File.read('spec/fixtures/unsplash/denver_co.json')


      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['photo_key']}&query=denver,co").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.6.0'
          }).
        to_return(status: 200, body: picture_api, headers: {})


        picture_response = PicturesService.city_picture('denver,co')
        expected_response = JSON.parse(picture_api, symbolize_names: true)

        expect(picture_response).to eq(expected_response)
    end
  end

end
