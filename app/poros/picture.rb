class Picture
  attr_reader :id, :image_url, :credits

  def initialize(data)
    @id = nil
    @image_url = data[:urls][:raw]
    @credits = generate_credits(data)
  end

  def generate_credits(data)
    {
      source: "From unsplash.com",
      photographer: data[:user][:name]
    }
  end
end
