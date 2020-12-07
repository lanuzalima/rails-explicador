class BookingsController < ApplicationController
  before_action :set_booking, except: [:create]

  def new
    @booking = Booking.new
  end

  def create

    @booking = Booking.new(booking_params)
    if book_valid?
      if @booking.save
        lecture_id = @booking.lecture.id
        redirect_to lecture_availability_booking_path(id: @booking.id,
                                                      lecture_id: lecture_id,
                                                      availability_id: @booking.availability_id),
                    notice: 'Aula cadastrada com sucesso!'
      else
        redirect_to lecture_availability_path(id: params[:availability_id],
                                              lecture_id: params[:lecture_id]),
                    notice: 'Aula indisponível para reserva. Por favor, escolha outro horário.'
      end
    else
      redirect_to lecture_availability_path(id: params[:availability_id],
                                            lecture_id: params[:lecture_id]),
                  alert: 'Horário já agendado. Por favor, escolha outro horário.'
    end
  end

  def show
  end

  def update
    @booking.update(booking_params)

    redirect_to pages_control_panel_path
  end

  def destroy
    @booking = Booking.destroy
  end

  private

  def book_valid?
    Booking.where(availability_id: params[:availability_id])
           .count.zero?
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.permit(:user_id, :availability_id, :confirmation)
  end
end
