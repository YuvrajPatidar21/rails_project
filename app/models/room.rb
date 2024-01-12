class Room < ApplicationRecord
  belongs_to :hotel
  belongs_to :room_type
  has_many :users, through: :bookings
  has_many :bookings
  has_many_attached :room_pictures

  enum status: [:Available, :Booked]
  before_create :set_default_status, if: :new_record?
  
  private           
    def set_default_status
      self.status ||= :Available
    end 
    

end
