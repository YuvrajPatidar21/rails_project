class Payment < ApplicationRecord
  belongs_to :booking

  after_create :mark_booking_status
  after_create :send_booking_status_booked
  after_create :assign_hotel_to_user
  before_create do
    self.amount = self.booking.calculate_amount
  end
  private

    def mark_booking_status
      puts "++++++++++++++++++++++++++++++"
      p booking.update(status: 'Booked')
      puts "++++++++++++++++++++++++++++"
      booking.update(status: 'Booked')
    end

    def send_booking_status_booked
      BookingMailer.booking_status_booked(self).deliver_now
    end

    def assign_hotel_to_user
      hotel = booking.room.hotel
      user = booking.user
    
      unless hotel.users.include?(user)
        hotel.users << user
      end
    end

end
