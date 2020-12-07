class LecturesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    if params[:query].present?
      @lectures = Lecture.global_search(params[:query])
    else
      @lectures = Lecture.all
    end
  end

  def new
    @lecture = Lecture.new
  end

  def show
    @lecture = Lecture.find(params[:id])
    authorize @lecture
    @availabilities = Availability.where(lecture_id: @lecture.id)
    @owner = Lecture.find(params[:id]).user
  end

  def create
    @lecture = Lecture.new(lecture_params)
    authorize @lecture
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
