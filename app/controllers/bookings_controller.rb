class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_broom, except: [:index, :show, :owner_bookings, :renter_bookings, :accept, :decline]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @broom = Broom.find(params[:broom_id])
  end

  def create
    @booking = Booking.new(booking_param)
    @booking.broom = @broom
    @booking.user = current_user
    @booking.status = 'Pending'
    dates = booking_param[:start_date].split(' to ')
    @booking.start_date = dates[0]
    @booking.end_date = dates[1]
    if @booking.save
      redirect_to bookings_renter_path
    else
      render 'brooms/show', alert: 'Sorry, booking failed.'
    end
  end

  def owner_bookings
    @owner_brooms = Broom.where(user: current_user)
    @owner_bookings = @owner_brooms.map do |owner_broom|
      owner_broom.bookings
    end.flatten
  end

  def renter_bookings
    @renter_bookings = current_user.bookings
  end

  def accept
    @booking = Booking.find(params[:id])
    if @booking.update(status: "Accepted")
      redirect_to bookings_owner_path, notice: 'You have accepted the booking request.'
    end
  end

  def decline
    @booking = Booking.find(params[:id])
    if @booking.update(status: "Declined")
      redirect_to bookings_owner_path, notice: 'Booking request declined.'
    end
  end

  private

  def set_broom
    @broom = Broom.find(params[:broom_id])
  end

  def booking_param
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
