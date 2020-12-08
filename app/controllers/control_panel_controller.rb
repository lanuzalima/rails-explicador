class ControlPanelController < ApplicationController

  def index
    @user_lectures = Lecture.where(user_id: current_user).order(created_at: :desc)
    @user_lectures_bookings = Booking.joins(:availability).joins(:lecture).where(lectures: { user_id: current_user.id }).order(created_at: :desc)
    @user_bookings = Booking.where(user_id: current_user).order(created_at: :desc).order(created_at: :desc)
    @lectures = organize_lectures(@user_lectures) if @user_lectures
    @lectures_bookings = organize_bookings(@user_lectures_bookings) if @user_lectures_bookings
    @bookings = organize_bookings(@user_bookings) if @user_bookings
  end

  def all_my_bookings
    @user_bookings = Booking.where(user_id: current_user).order(created_at: :desc).order(created_at: :desc)
    @bookings = organize_bookings(@user_bookings) if @user_bookings
  end

  def all_my_lectures
    @user_lectures = Lecture.where(user_id: current_user).order(created_at: :desc)
    @lectures = organize_lectures(@user_lectures) if @user_lectures
  end

  def all_my_availabilities
    @user_lectures_bookings = Booking.joins(:availability).joins(:lecture).where(lectures: { user_id: current_user.id }).order(created_at: :desc)
    @lectures_bookings = organize_bookings(@user_lectures_bookings) if @user_lectures_bookings
  end

  private

  def organize_bookings(user_bookings)
    bookings = { confirmed: [], not_confirmed: [], denied: [] }
    user_bookings.each do |booking|
      if booking.confirmation
        bookings[:confirmed] << booking
      elsif booking.confirmation.nil?
        bookings[:not_confirmed] << booking
      else
        bookings[:denied] << booking
      end
    end
    bookings
  end

  def organize_lectures(user_lectures)
    lectures = { availables: [], not_availables: [] }
    user_lectures.each do |lecture|
      if available?(lecture)
        lectures[:availables] << lecture
      else
        lectures[:not_availables] << lecture
      end
    end
    lectures
  end

  def available?(lecture)
    bookings = Booking.joins(:availability)
                      .where(availabilities: { lecture_id: lecture.id })
                      .count
    availabilities = Availability.where(lecture_id: lecture.id).count
    (availabilities - bookings).positive?
  end
end
