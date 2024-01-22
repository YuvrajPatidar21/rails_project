class Customer::DashboardController < ApplicationController
  layout 'admin_panel'

  def index
    @hotels_count = Hotel.all
    @hotels = Hotel.all.page(params[:page]).per(3)
    @bookings = current_user.bookings
    @payments = current_user.payments
  end
end
