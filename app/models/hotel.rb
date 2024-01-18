class Hotel < ApplicationRecord
  has_and_belongs_to_many :users, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :room_types, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :bookings, through: :rooms
  has_many :payments, through: :bookings
  has_many_attached :hotel_pictures 
end
