class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:index, :new, :create, :show, :destroy]

  def index
    @bookings = @room.bookings.page(params[:page]).per(10)
  end
  
  def show
    @booking = @room.bookings.find(params[:id])
  end
  
  def display_booking
    if current_user.owner?
      # @bookings = Booking.all
      @bookings = Booking.all.page(params[:page]).per(10)
    elsif current_user.manager?
      current_user.hotels.each do |hotel|
        @bookings = hotel.bookings.page(params[:page]).per(10)
      end
    else
      @bookings = current_user.bookings.page(params[:page]).per(10)
    end
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = @room.bookings.new(booking_params)
    if @booking.save
      redirect_to hotel_room_booking_path(@room.hotel, @room, @booking), notice: "Booking is pending now. For confirm make payment."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = @room.bookings.find(params[:id])
    if @booking.destroy
      @room.update(status: 'Available')
      redirect_to display_booking_path, notice: "Booking was successfully Cancled."
    else
      redirect_to hotel_room_booking_path, alert: "Failed to Cancle."
    end
  end

  private

    def set_room
      @room = Room.find(params[:room_id])
    end

    def booking_params
      if current_user.owner? || current_user.manager?
        params.require(:booking).permit(:start_date, :end_date, :room_id, :user_id)
      else
        params.require(:booking).permit(:start_date, :end_date, :room_id).merge(user: current_user)
      end
    end
end
