class PaymentsController < ApplicationController
  before_action :set_booking
  before_action :set_payment, only: %i[ show ]

  def index
    @payment = @booking.payment
  end

  def show
  end

  def new
    @payment = @booking.build_payment
  end

  def create
    @payment = @booking.build_payment(payment_params)
    if @payment.save
      redirect_to booking_payment_path(@booking, @payment), notice: "Done Payment."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def destroy
  #   if @payment.destroy!
  #     redirect_to booking_payments_path, notice: "Payment was successfully cancled."
  #   else
  #     redirect_to booking_payment_path, notice: "Payment was not successfully cancled."
  #   end
  # end

  private
    def set_booking
      @booking = Booking.find_by(id: params[:booking_id])
    end
    def set_payment
      @payment = @booking.payment
    end

    def payment_params
      params.require(:payment).permit(:card_holder_name, :card_number, :cvv, :bank_name, :amount, :payment_date, :booking_id)
    end
end
