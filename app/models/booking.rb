class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one :payment, dependent: :destroy 

  before_create :mark_booing_as_pending

  private
    def mark_booing_as_pending
      self.status ||= "Pending"
    end
end
