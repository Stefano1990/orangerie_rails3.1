module PhotosHelper
  def number_of_rows_photos
    photos_per_row = 3.0
    number_of_photos = @photos.count
    n = (number_of_photos / photos_per_row).ceil # number of rows required
    n.to_i
  end
  def photo_thumb(options={})
    unless @photos[options[:i]].nil?
      photo = @photos[options[:i]]
      raw %(#{link_to(image_tag(photo.image.url(:album)),user_album_photo_path(photo.user, photo.album, photo))})
    end
  end
end