class BookingsController < ApplicationController
  before_action :set_booking

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.availability = @availability
    @booking.user = current_user

    if @booking.save
      redirect_to booking_path(@booking)
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
    @booking = Booking.destroy
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def booking_params
    params.require(:booking).permit(:confirmation)
  end
end
