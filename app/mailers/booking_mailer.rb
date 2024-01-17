class BookingMailer < ApplicationMailer
  def booking_status_pending(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Booking status is pending')
  end

  def booking_status_booked(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Booking status is booked')
  end

  def booking_cancle(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Booking cancled')
  end
end
