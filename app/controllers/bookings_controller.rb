class BookingsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update]

  def index
    @bookings = policy_scope(Booking).order(start_date: :asc)
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
    params.require(:booking).permit(policy(@booking).permitted_attributes)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
