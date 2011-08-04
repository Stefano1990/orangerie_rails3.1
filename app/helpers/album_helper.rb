module AlbumHelper
  def number_of_rows
    albums_per_row = 3.0
    number_of_albums = @user.albums.count.to_f
    n = (number_of_albums / albums_per_row).ceil # number of rows required
    n.to_i
  end
  def album_thumb(options={})
    unless @user.albums[options[:i]].nil?
      unless @user.albums[options[:i]].photos.empty?
        album = @user.albums[options[:i]]
        raw %(#{link_to(image_tag(album.photos.first.image.url, :height => "145", :width => "145"),user_album_photos_path(album.user, album))}
            <div class="albumInfos">#{link_to(album.title,user_album_photos_path(album.user, album))}
            <div>#{t('users.albums.photo', :count => album.photos.count)}</div></div>)
      end
    end
  end
end
