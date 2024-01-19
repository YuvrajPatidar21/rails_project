class Admin::DashboardController < ApplicationController
  layout 'admin_panel'

  def index
    @hotels_count = Hotel.all
    @hotels = Hotel.all.page(params[:page]).per(3)
    @bookigs = Booking.all
    @users = User.all
    @contacts = Contact.all
    @payments = Payment.all
    @rooms = Room.all
    
    
  end

  def display_user
    @users = User.all.page(params[:page]).per(10)
  end

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_dashboard_display_user_path, notice: "New User registered successfully." 
    else
      render 'new_user' , status: :unprocessable_entity
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :mobile, :address, :city, :date_of_birth, :status, :role, :state, :zipcode, :password, :password_confirmation, :hotel_ids, :profile_picture)
    end
end
