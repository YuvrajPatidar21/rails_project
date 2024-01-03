json.extract! hotel, :id, :name, :email, :telephone, :location, :city, :state, :zipcode, :description, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
