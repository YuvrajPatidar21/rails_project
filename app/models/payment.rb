class Payment < ApplicationRecord
  belongs_to :booking

  validates :card_holder_name, presence: true
  validates :card_number, presence: true, numericality: { only_integer: true }, length: { minimum: 16, maximum: 19}
  validates :cvv, presence: true, numericality: { only_integer: true }, length: { is: 3}
  validates :bank_name, presence: true
  
  after_create :mark_booking_status
  after_create :send_booking_status_booked
  after_create :assign_hotel_to_user

  before_create do
    self.amount = self.booking.calculate_amount
  end
  private
  
    def assign_hotel_to_user
      hotel = booking.room.hotel
      user = booking.user
    
      unless hotel.users.include?(user)
        hotel.users << user
      end
    end

    def mark_booking_status
      booking.update(status: 'Booked')
    end

    def send_booking_status_booked
      BookingMailer.booking_status_booked(self).deliver_now
    end


end
