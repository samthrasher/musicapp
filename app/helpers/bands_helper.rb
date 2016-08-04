module BandsHelper

  def render_album_title(album)
    "#{album.title} #{"(LIVE)" if album.live}"
  end
  
end
