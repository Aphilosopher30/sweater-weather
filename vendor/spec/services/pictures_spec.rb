require 'rails_helper'

RSpec.describe PicturesService do

  describe "returns picture " do
    it "returns the desired pict" do

      json_response = File.read('spec/fixtures/pictures.json')

      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['photo_key']}&query=Denver,CO").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.4.2'
          }).
        to_return(status: 200, body: json_response, headers: {})

        test = PicturesService.city_picture('Denver,CO')
        expected = JSON.parse(json_response, symbolize_names: true)

        expect(test).to eq(expected)
    end
  end

end
