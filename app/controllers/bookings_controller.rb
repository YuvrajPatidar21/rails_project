class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:index, :new, :create, :edit, :update, :show, :destroy]

  def index
    @bookings = @room.bookings
  end
  
  def show
    @booking = @room.bookings.find(params[:id])
  end
  
  def display_booking
    if current_user.admin?
      @bookings = Booking.all
    elsif current_user.customer?
      @bookings = current_user.bookings
    end
  end

  def new
    @booking = Booking.new
  end

  def edit
    @booking = @room.bookings.find(params[:id])
  end

  def create
    @booking = @room.bookings.new(booking_params)
    if @booking.save
      redirect_to hotel_room_booking_path(@room.hotel, @room, @booking), notice: "Booking was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @booking = @room.bookings.find(params[:id])
    if @booking.update(booking_params)
      redirect_to hotel_room_booking_path(@room.hotel, @room, @booking), notice: "Booking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = @room.bookings.find(params[:id])
    if @booking.destroy
      @room.update(status: 'Available')
      redirect_to hotel_room_bookings_path, notice: "Booking was successfully destroyed."
    else
      redirect_to hotel_room_booking_path, alert: "Failed to destroy booking."
    end
  end

  private

    def set_room
      @room = Room.find(params[:room_id])
    end

    def booking_params
      params.require(:booking).permit(:start_date, :end_date, :room_id).merge(user: current_user)
    end
end