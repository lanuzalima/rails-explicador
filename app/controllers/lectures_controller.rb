class LecturesController < ApplicationController
  def index
    @lectures = Lecture.all
  end

  def new
    @lecture = Lecture.new
  end

  def show
    @lecture = Lecture.find(params[:id])
    @availabilities = Availability.where(lecture_id: @lecture.id)
    @owner = Lecture.find(params[:id]).user
  end

  def create
    @lecture = Lecture.new(lecture_params)
    @lecture.user = current_user

    if @lecture.save
      redirect_to lecture_path(@lecture)
    else
      render 'new'
    end
  end

  private

  def lecture_params
    params.require(:lecture).permit(:title, :subject, :description, :duration)
  end
end
