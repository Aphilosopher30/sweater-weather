require 'rails_helper'

RSpec.describe Picture do

  context 'the Pictures class exists and has attributes' do
    it 'has atrributes' do

      input = {
        image_url: 'url_string',
        credits: {test1: 'test2'},
      }

      picts = Picture.new(input)

      expect(picts.id).to eq(nil)

      expect(picts.image_url).to eq('url_string')
      expect(picts.credits).to eq({test1: 'test2'})
    end
  end
end
