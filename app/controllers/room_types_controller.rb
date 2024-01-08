class RoomTypesController < ApplicationController
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

    respond_to do |format|
      if @room_type.save
        format.html { redirect_to room_type_url(@room_type), notice: "Room type was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @room_type.update(room_type_params)
        format.html { redirect_to room_type_url(@room_type), notice: "Room type was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @room_type.destroy!

    respond_to do |format|
      format.html { redirect_to room_types_url, notice: "Room type was successfully destroyed." }
    end
  end

  private
    def set_room_type
      @room_type = RoomType.find(params[:id])
    end

    def room_type_params
      params.require(:room_type).permit(:name, :price, :description, :capacity)
    end
end
