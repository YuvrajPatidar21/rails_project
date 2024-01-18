class PaymentsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_booking
  before_action :set_payment, only: %i[ show invoice ]

  def display_payment
    if current_user.admin?
      @payments = Payment.all
    elsif current_user.manager?
      current_user.hotels.each do |hotel|
        @payments = hotel.payments
      end
    else
      @payments = current_user.payments
    end
  end

  def show
  end

  def invoice
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@payment.booking.user.name}_invoice", template: "payments/invoice", formats: [:html] , layout: 'invoice', page_size: 'A4'  # Excluding ".pdf" extension.
      end
    end
  end

  def new
    @payment = @booking.build_payment
    @payment.amount = @booking.calculate_amount
  end

  def create
    @payment = @booking.build_payment(payment_params)
    if @payment.save
      redirect_to booking_payment_path(@booking, @payment), notice: "Done Payment."
    else
      render :new, status: :unprocessable_entity
    end
  end

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
