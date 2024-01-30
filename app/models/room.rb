class Room < ApplicationRecord
  belongs_to :hotel
  belongs_to :room_type
  has_many :bookings,dependent: :destroy
  has_many :users, through: :bookings
  has_many_attached :room_pictures

  validates :room_number, presence: true
  validates :status, presence: true
  
  enum status: [:Available, :Booked]
  before_create :set_default_status, if: :new_record?
  
  def availability?(start_date, end_date, room_id)
    conflicting_bookings = bookings.where(room_id: room_id).where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_Date >= ?)', start_date, start_date, end_date, end_date)
    conflicting_bookings.empty?
  end

  private           
    def set_default_status
      self.status ||= :Available
    end 
end
