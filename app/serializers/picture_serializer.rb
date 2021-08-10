class PictureSerializer
  include FastJsonapi::ObjectSerializer
  set_type :image
  attributes :image_url, :credits
end
