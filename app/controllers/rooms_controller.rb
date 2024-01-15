class RoomsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  
  before_action :set_hotel
  before_action :set_rooms, only: %i[show edit update destroy]
  
  def index
    @rooms = @hotel.rooms
  end

  def show
  end

  def new
    @room = @hotel.rooms.new
  end

  def edit
  end

  def create
    @room = @hotel.rooms.new(room_params)
    if @room.save
      redirect_to hotel_rooms_path(@hotel), notice: "Room was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      format.html { redirect_to hotel_rooms_path(@hotel), notice: "Room was successfully updated." }
    else
      format.html { render :edit, status: :unprocessable_entity }
    end
  end

  def destroy
    if @room.destroy!
      redirect_to hotel_rooms_path, notice: "Room was successfully destroyed."
    else
      redirect_to hotel_room_path, notice: "Room was not destroyed."
    end
  end

  private

    def set_hotel
      @hotel = Hotel.find_by(id: params[:hotel_id])
    end
    def set_rooms
      @room = @hotel.rooms.find(params[:id])
    end
    def room_params
      params.require(:room).permit(:room_number, :status, :room_type_id, room_pictures: [])
    end
end
