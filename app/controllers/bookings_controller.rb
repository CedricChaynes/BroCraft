class BookingsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_booking, only: [:show, :approve, :reject, :edit, :update]

  def index
    @bookings_as_owner = current_user.owned_bookings
    @bookings_as_renter = policy_scope(Booking).where(renter_id: current_user.id).order(status: :asc)
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
    params.require(:booking).permit(:id, :status)
  end

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end
end
