class Manager::DashboardController < ApplicationController
  layout 'admin_panel'
  
  def index
    @hotels = current_user.hotels
  end
  
  def display_user
    current_user.hotels.each do |hotel|
      @users = hotel.users.where(role: 'customer')
    end
  end
  
end
