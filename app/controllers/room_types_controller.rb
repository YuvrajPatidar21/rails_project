class RoomTypesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  
  before_action :set_room_type, only: %i[ show edit update destroy ]

  def index
    @room_types = RoomType.all
  end

  def show
  end

  def new
    @room_type = RoomType.new
  end

  def edit
  end

  def create
    @room_type = RoomType.new(room_type_params)
    if @room_type.save
      redirect_to room_type_url(@room_type), notice: "Room type was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @room_type.update(room_type_params)
      redirect_to room_type_url(@room_type), notice: "Room type was successfully updated."
    else
        render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @room_type.destroy!
      redirect_to room_types_url, notice: "Room type was successfully destroyed."
    else
      redirect_to room_type_url, notice: "Room type was not destroyed."
    end
  end

  private
    def set_room_type
      @room_type = RoomType.find(params[:id])
    end

    def room_type_params
      params.require(:room_type).permit(:name, :price, :description, :capacity, :rooms_type_picture )
    end
end
