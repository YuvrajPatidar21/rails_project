class RoomType < ApplicationRecord
  belongs_to :hotel
  has_many :rooms, dependent: :destroy
  has_one_attached :rooms_type_picture

  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true} 
  validates :description, presence: true, length: { minimum: 50 }
  validates :capacity, presence: true, numericality: { only_integer: true }

  before_save do
    self.name = name.titleize
    self.description = description.capitalize
  end

end
