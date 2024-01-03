class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :email
      t.bigint :telephone
      t.string :location
      t.string :city
      t.string :state
      t.bigint :zipcode
      t.text :description

      t.timestamps
    end
  end
end
