class Manager::DashboardController < ApplicationController
  layout 'admin_panel'
  
  def index
    @hotels_count = Hotel.all
    @hotels = current_user.hotels

    current_user.hotels.each do |hotel|
      @users = hotel.users.where(role: 'customer')
      @bookigs = hotel.bookings.where(status: 'Booked')
      @payments = hotel.payments
      @rooms = hotel.rooms
    end
    @contacts = Contact.all  
  end
  
  def display_user
    current_user.hotels.each do |hotel|
      @users = hotel.users.where(role: 'customer').page(params[:page]).per(10)
    end
  end
  
end
