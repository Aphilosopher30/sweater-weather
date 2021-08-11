require 'rails_helper'

RSpec.describe RoadTrip, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:start_city) }
    it { should validate_presence_of(:end_city) }
  end

end
