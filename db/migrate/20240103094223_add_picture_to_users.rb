class AddPictureToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :profile_picture, :binary
  end
end
