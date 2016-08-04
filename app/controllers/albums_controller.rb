class AlbumsController < ApplicationController
  before_filter do
    redirect_to new_session_url unless current_user
  end

  def new
    @bands = Band.all
    @album = Album.new(band_id: params[:id])
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @bands = Band.all
    @album = Album.find_by_id(params[:id])
  end

  def show
    @album = Album.includes(:tracks, :band).find_by_id(params[:id])
  end

  def update
    @album = Album.find_by_id(params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.includes(:band).find_by_id(params[:id])

    if @album.destroy
      redirect_to band_url(@album.band)
    else
      flash.now[:errors] = ["Album cannot be deleted."]
      render :show
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id, :live)
  end
end
