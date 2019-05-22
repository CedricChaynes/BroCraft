class BookingsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_booking, only: [:show, :approve, :reject, :edit, :update]
  before_action :skip_authorization, only: %i[search filter create new]

  def contact
    @booking = Booking.new
  end

  def index
    @bookings = policy_scope(Booking).order(start_date: :asc)
  end

  def show
  end

  def new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.renter = current_user
    @booking.tool = Tool.find(params[:tool_id])

    @booking.save!

    redirect_to bookings_path
    authorize @booking


  end

  def edit
  end

  def update
    if @booking.update_attributes(permitted_attributes(@booking))
      redirect_to @booking
    else
      render :edit
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
