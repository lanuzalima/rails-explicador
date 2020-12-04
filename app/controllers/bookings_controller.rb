class BookingsController < ApplicationController
  before_action :set_booking, except: [:create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      lecture_id = @booking.lecture.id
      redirect_to lecture_availability_booking_path(id: @booking.id, lecture_id: lecture_id, availability_id: @booking.availability_id)
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
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.permit(:user_id, :availability_id, :confirmation)
  end
end
