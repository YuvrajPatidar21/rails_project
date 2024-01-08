class CreateRoomTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :room_types do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :capacity

      t.timestamps
    end
  end
end
