class RoomType < ApplicationRecord
  belongs_to :hotel
  has_many :rooms, dependent: :destroy
  has_one_attached :rooms_type_picture
end
