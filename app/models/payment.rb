class Payment < ApplicationRecord
  belongs_to :booking

  after_create :mark_booking_status
  after_create :mark_room_status

  private

    def mark_booking_status
      booking.update(status: 'Booked')
    end
    
    def mark_room_status
      booking.room.update(status: 'Booked')
    end
end
