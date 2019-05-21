class ToolsController < ApplicationController
  before_action :set_tool, only: %i[show edit update destroy]

  def index
    @tools = Tool.all
  end

  def show
  end

  def new
    @tool = Tool.new
  end

  def create
    @user = User.find(params[:user_id])
    @tool = Tool.new(tool_params)
    @tool.owner = @user
    @tool.save!
    redirect_to users_tools
  end

  def edit
  end

  def update
    @tool.update(tool_params)
  end

  def destroy
    @tool.destroy!
    redirect_to users_tools
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :description, :price_per_day, :category)
  end

  def set_tool
    @tool = Tool.find(params[:id])
  end
end
