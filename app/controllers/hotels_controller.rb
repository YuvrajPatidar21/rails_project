class HotelsController < ApplicationController
  load_and_authorize_resource
  before_action :set_hotel, only: %i[ show edit update destroy ]

  def index
      @hotels = Hotel.all
  end

  def show
    @services = @hotel.services
  end

  def new
    @hotel = Hotel.new
  end

  def edit
  end

  def create
    @hotel = Hotel.new(hotel_params)
      if @hotel.save
        redirect_to hotel_url(@hotel), notice: "Hotel was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update
      if @hotel.update(hotel_params)
        redirect_to hotel_url(@hotel), notice: "Hotel was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    if @hotel.destroy!
      redirect_to hotels_url, notice: "Hotel was successfully destroyed."
    else
      redirect_to hotel_url, notice: "Hotel was not destroyed."
    end
  end

  private
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end

    def hotel_params
      params.require(:hotel).permit(:name, :email, :telephone, :location, :city, :state, :zipcode, :description, hotel_pictures: [])
    end
end