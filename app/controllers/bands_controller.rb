class BandsController < ApplicationController
  before_filter do
    redirect_to new_session_url unless current_user
  end

  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find_by_id(params[:id])
  end

  def update
    @band = Band.find_by_id(params[:id])

    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def show
    @band = Band.find_by_id(params[:id])
    @albums = @band.albums
  end

  def destroy
    @band = Band.find_by_id(params[:id])

    if @band.destroy
      redirect_to bands_url
    else
      flash.now[:errors] = ["Band could not be destroyed"]
      render :show
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
