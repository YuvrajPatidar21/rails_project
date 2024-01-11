class Room < ApplicationRecord
  belongs_to :hotel
  belongs_to :room_type
  has_many_attached :room_pictures

  enum status: [:vacant, :occupied, :maintenance]

  after_initialize :set_default_status, if: :new_record?
              
  def set_default_status
    self.status ||= :vacant
  end
end
