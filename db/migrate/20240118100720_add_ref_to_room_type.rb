class AddRefToRoomType < ActiveRecord::Migration[7.1]
  def change
    add_reference :room_types, :hotel, foreign_key: true
  end
end
