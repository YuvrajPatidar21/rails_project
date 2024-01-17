class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one :payment, dependent: :destroy 

  before_create :mark_booing_as_pending
  after_save :send_booking_status
  after_destroy :send_cancllation
  
  def calculate_amount
    ((self.end_date.to_date - self.start_date.to_date).to_i + 1) * self.room.room_type.price
  end

  private

    def mark_booing_as_pending
      self.status ||= "Pending"
    end

    def send_booking_status
      if self.status == "Pending"
        BookingMailer.booking_status_pending(self).deliver_now
      else
        BookingMailer.booking_status_booked(self).deliver_now
      end
    end

    def send_cancllation
      BookingMailer.booking_cancle(self).deliver_now
    end
end
