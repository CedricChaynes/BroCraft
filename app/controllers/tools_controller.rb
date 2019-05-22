
class ToolsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_tool, only: %i[show edit update destroy]
  before_action :skip_authorization, only: %i[search filter]

  def index
    @tools = policy_scope(Tool).order(name: :asc)
  end

  def owner_index
    @tools = policy_scope(Tool).where(owner_id: current_user.id).order(name: :asc)
  end

  def show
    @user = current_user
    @booking = Booking.new
    authorize @tool
  end

  def new
    @tool = Tool.new
    authorize @tool
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.owner = current_user
    @tool.save!
    redirect_to my_tools_tools_path
    authorize @tool
  end

  def edit
  end

  def update
    @tool.update(tool_params)
    authorize @tool
  end

  def destroy
    @tool.destroy!
    redirect_to users_tools
  end

  def search
    @search = params[:search]
    @name = @search[:name]
    @tools = Tool.where('name ILIKE ?', "%#{@name}%")
  end

  def filter
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :description, :price_per_day, :category, :photo)
  end

  def set_tool
    @tool = Tool.find(params[:id])
  end
end
