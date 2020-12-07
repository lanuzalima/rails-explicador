class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: %i[show edit update destroy]
  before_action :set_lecture, only: %i[show new create]

  def show
    @booking = Booking.where(availability_id: params[:id]) if has_booking?
  end

  def new
    @availability = Availability.new
  end

  def create
    @availability = Availability.new(availability_params)
    @availability.lecture = @lecture
    if @availability.start_time > Time.zone.now && @availability.save
      redirect_to lecture_availability_path(@lecture, @availability)
    else
      flash[:alert] = 'Data não pode ser inferior à atual'
      render 'new'
    end
  end

  def edit; end

  def update
    @availability.update(availability_params)

    redirect_to lecture_availability_path(@availability)
  end

  def destroy
    @availability.destroy
    lecture = @availability.lecture

    redirect_to lecture_path(lecture)
  end

  private

  def set_availability
    @availability = Availability.find(params[:id])
  end

  def set_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end

  def availability_params
    params.require(:availability).permit(:start_time)
  end

  def has_booking?
    Booking.where(availability_id: params[:id])
           .count.positive?
  end
end
