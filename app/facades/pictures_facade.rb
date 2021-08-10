class PicturesFacade

  def self.city_picture(city_state)
    pictures = PicturesService.city_picture(city_state)
    all_info = pictures[:results].first
    Picture.new(all_info)
  end

end
