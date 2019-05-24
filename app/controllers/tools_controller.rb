class ToolsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_tool, only: %i[show edit update destroy]
  before_action :skip_authorization, only: %i[search filter create new]

  def owner_index
    @tools = policy_scope(Tool).where(owner_id: current_user.id).order(name: :asc)
  end

  def show
    @user = current_user
    @booking = Booking.new
    @tool = Tool.find(params[:id])
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
    authorize @tool
  end

  def update
    @tool.update(tool_params)
    redirect_to tool_path(@tool)
    authorize @tool
  end

  def destroy
    @tool.destroy!
    redirect_to users_tools
  end

  def search
    @search = params[:searchform]
    @name = @search[:name]
    @category = @search[:category]
    @start_date = @search[:start_date]
    @end_date = @search[:end_date]
    search_params = { name: @name, category: @category }
    @tools = Tool.search(search_params)
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
