class Customer::DashboardController < ApplicationController
  layout 'admin_panel'
  def index
    @hotels = Hotel.all
  end
end
