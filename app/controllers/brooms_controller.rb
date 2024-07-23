class BroomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @brooms = Broom.all
    @markers = @brooms.geocoded.map do |broom|
      {
        lat: broom.latitude,
        lng: broom.longitude
      }
    end
    if params[:query].present?
      @brooms = Broom.search_by_name_and_description(params[:query])
    end
  end

  def show
    @broom = Broom.find(params[:id])
    @booking = Booking.new
  end

  def new
    @broom = Broom.new
  end

  def create
    @broom = Broom.new(broom_params)
    @broom.user = current_user
    if @broom.save
      redirect_to broom_path(@broom)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @broom = Broom.find(params[:id])
    @broom.destroy
    redirect_to brooms_path
  end

  private

  def broom_params
    params.require(:broom).permit(:name, :description, :photo, :price, :address)
  end
end
