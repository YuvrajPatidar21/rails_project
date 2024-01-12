class ServicesController < ApplicationController
  before_action :set_hotel
  before_action :set_services, only: %i[show edit update destroy]

  def index
    @services = @hotel.services
  end

  def show
  
  end

  def new
    @service = @hotel.services.new
  end

  def edit
  end

  def create
    @service = @hotel.services.new(service_params)
    if @service.save
      redirect_to hotel_services_path(@hotel), notice: "Service was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
      if @service.update(service_params)
      redirect_to hotel_services_path(@hotel), notice: "Service was successfully updated."
      else
        render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @service.destroy!
      redirect_to hotel_services_path, notice: "Service was successfully destroyed."
    else
      redirect_to hotel_service_path, notice: "Service was not destroyed."
    end
  end

  private
  
    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])
    end

    def set_services
      @service = @hotel.services.find(params[:id])
    end
    def service_params
      params.require(:service).permit(:name, :description, :service_picture)
    end
end
