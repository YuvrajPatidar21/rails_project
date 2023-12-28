class AddDetailsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :state, :string
    add_column :users, :zipcode, :bigint
  end
end
