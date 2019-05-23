class BookingsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_booking, only: %i[show approve reject edit update]
  before_action :skip_authorization, only: %i[search filter create new]

  def contact
    @booking = Booking.new
  end

  def index
    @bookings_as_owner = current_user.owned_bookings.where.not(status: "rejected").order("status DESC, start_date ASC")
    @bookings_as_renter = policy_scope(Booking).where(renter_id: current_user.id).where.not(status: "rejected").order("status DESC, start_date ASC")
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

  def approve
    @booking.status = "approved"
    @booking.save!
    redirect_back(fallback_location: bookings_path)
  end

  def reject
    @booking.status = "rejected"
    @booking.save!
    redirect_back(fallback_location: bookings_path)
  end

  def update
    @booking.update(booking_params)
    redirect_to @booking
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :id, :status)
  end

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end
end
