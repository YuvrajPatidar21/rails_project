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

    respond_to do |format|
      if @service.save
        format.html { redirect_to hotel_services_path(@hotel), notice: "Service was successfully created." }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to hotel_services_path(@hotel), notice: "Service was successfully updated." }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @service.destroy!

    respond_to do |format|
      format.html { redirect_to hotel_rooms_path, notice: "Service was successfully destroyed." }
      format.json { head :no_content }
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
      params.require(:service).permit(:name, :description)
    end
end
