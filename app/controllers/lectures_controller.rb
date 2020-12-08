class LecturesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :set_lecture, only: %i[show edit update destroy]

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
    authorize @lecture
    @availabilities = Availability.where(lecture_id: @lecture.id)
    @owner = @lecture.user
    @booking = Booking.new
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

  def edit; end

  def update
    @lecture.update(lecture_params)
    authorize @lecture

    redirect_to lecture_path(@lecture)
  end

  def destroy
    authorize @lecture
    @lecture.destroy

    redirect_to lectures_path
  end

  private

  def set_lecture
    @lecture = Lecture.find(params[:id])
  end

  def lecture_params
    params.require(:lecture).permit(:title, :subject, :description, :duration)
  end
end
