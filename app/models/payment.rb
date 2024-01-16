class Payment < ApplicationRecord
  belongs_to :booking

  after_create :mark_booking_status
  after_create :mark_room_status
  before_create do
    self.amount = self.booking.calculate_amount
  end
  private

    def mark_booking_status
      booking.update(status: 'Booked')
    end
    
    def mark_room_status
      booking.room.update(status: 'Booked')
    end
end
