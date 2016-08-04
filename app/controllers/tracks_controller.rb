class TracksController < ApplicationController
  before_filter do
    redirect_to new_session_url unless current_user
  end

  def new
    @track = Track.new(album_id: params[:id])
    @album = Album.find_by_id(params[:id])
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end

  end

  def edit
    #allow user to change album of track?
    @track = Track.find_by_id(params[:id])
  end

  def show
    @track = Track.includes(:album, :band).find_by_id(params[:id])
  end

  def update
    @track = Track.find_by_id(params[:id])

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end

  end

  def destroy
    @track = Track.find_by_id(params[:id])

    if @track.destroy
      redirect_to tracks_url
    else
      flash.now[:errors] = ["Track is invincible and could not be deleted."]
      render :show
    end

  end

  def track_params
    params.require(:track).permit(:title, :album_id, :bonus, :lyrics)
  end
end
