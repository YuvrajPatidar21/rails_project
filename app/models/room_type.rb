class RoomType < ApplicationRecord
  has_many :rooms
  has_one_attached :rooms_type_picture
end
