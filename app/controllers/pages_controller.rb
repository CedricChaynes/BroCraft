class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @name = @search[:name] if @search.present?
    @tools = Tool.where('name ILIKE ?', "%#{@name}%") if @search.present?
  end
end
