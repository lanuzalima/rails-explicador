class PagesController < ApplicationController
  def home
    @lectures = Lecture.all
  end

  def show
    @lecture = Lecture.find(params[:id])
    @availabilities = Availability.where(lecture_id: @lecture.id)
    @owner = Lecture.find(params[:id]).user
  end

end
