class PagesController < ApplicationController
  def home
    @lectures = Lecture.all
  end

  def show
    @lecture = Lecture.find(params[:id])
    @availabilities = Availability.where(lecture_id: @lecture.id)
    @owner = Lecture.find(params[:id]).user
  end

  def control_panel
    @user_lectures = Lecture.where(user_id: current_user).order(created_at: :desc)
    @user_lectures_bookings = Booking.joins(:availability).joins(:lecture).where(user_id: current_user.id)
    @user_bookings = Booking.where(user_id: current_user).order(created_at: :desc).order(created_at: :desc)
    @lectures = organize_lectures(@user_lectures) if @user_lectures
    @lectures_bookings = organize_bookings(@user_lectures_bookings) if @user_lectures_bookings
    @bookings = organize_bookings(@user_bookings) if @user_bookings
  end

  private

  def organize_bookings(user_bookings)
    bookings = { confirmed: [], not_confirmed: [] }
    user_bookings.each do |booking|
      if booking.confirmation
        bookings[:confirmed] << booking
      else
        bookings[:not_confirmed] << booking
      end
    end
    bookings
  end

  def organize_lectures(user_lectures)
    lectures = { availables: [], not_availables: [] }
    user_lectures.each do |lecture|
      if Availability.where(lecture_id: lecture.id).count.positive?
        lectures[:availables] << lecture
      else
        lectures[:not_availables] << lecture
      end
    end
    lectures
  end
end
