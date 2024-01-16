class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one :payment, dependent: :destroy 

  before_create :mark_booing_as_pending
  
  def calculate_amount
    ((self.end_date.to_date - self.start_date.to_date).to_i + 1) * self.room.room_type.price
  end

  private
    def mark_booing_as_pending
      self.status ||= "Pending"
    end
end
