require 'rails_helper'

RSpec.describe Picture do

  context 'the Pictures class exists and has attributes' do
    it 'has atrributes' do

      picture_api_response = File.read('spec/fixtures/unsplash/denver_co.json')
      picture_info = JSON.parse(picture_api_response, symbolize_names: true)

      picts = Picture.new(picture_info[:results][0])

      expect(picts.id).to eq(nil)

      expect(picts.image_url).to eq('https://images.unsplash.com/photo-1619856699906-09e1f58c98b1?ixid=MnwyMzk1NTh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2Mjg1NDk4NzE&ixlib=rb-1.2.1')
      expect(picts.credits).to eq({photographer: "Ryan De Hamer", source: "From unsplash.com"})
    end
  end
end
