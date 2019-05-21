class BookingsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking.renter = current_user
    @booking.tool = Tool.find(params[:tool_id])
    @tool.save!
    redirect_to tool_path
  end

  def edit
  end

  def update
    @booking.update(booking_params)
  end

  private

  def booking_params
    params.require(:booking).permit(:tool_id, :status, :start_date, :end_date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
