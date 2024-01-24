class RoomType < ApplicationRecord
  belongs_to :hotel
  has_many :rooms, dependent: :destroy
  has_one_attached :rooms_type_picture

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_integer: true} 
  validates :descriptions, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true }

  


end
