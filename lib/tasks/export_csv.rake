namespace :export_csv do
  desc "Generate the CSV file for user model"
  task users_csv: :environment do
    require 'csv'

    csv_file_path = Rails.root.join('csv-file','user-csv' ,"users-list-#{Date.today}.csv")

    users = User.all

    attribute_names = User.attribute_names

    CSV.open(csv_file_path, "wb") do |csv|
      csv << attribute_names

      users.each do |user|
        csv << user.attributes.values_at(*attribute_names)
      end
    end
  end

  desc "Generate the CSV file for hotel model"
  task hotels_csv: :environment do
    require 'csv'

    csv_file_path = Rails.root.join('csv-file','hotel-csv',"hotels_list-#{Date.today}.csv")

    hotels = Hotel.all

    attribute_names = Hotel.attribute_names

    CSV.open(csv_file_path, "wb",headers: attribute_names) do |csv|
      csv << attribute_names

      hotels.each do |hotel|
        csv << hotel.attributes.values_at(*attribute_names)
      end
    end
  end

  desc "Generate the CSV file for booking model"
  task bookings_csv: :environment do
    require 'csv'

    csv_file_path = Rails.root.join('csv-file','booking-csv' ,"bookings-list-#{Date.today}.csv")

    bookings = Booking.all

    # attribute_names = ["ID", "Check-in Date", "Check-out date", "Hotel-name", "Room-name", "Price /day", "Customer-name", "Status", "Created_at", "Updated-at" ]
    attribute_names = Booking.attribute_names
    CSV.open(csv_file_path, "wb",headers: attribute_names) do |csv|
      csv << attribute_names

      bookings.each do |booking|
        # csv << [booking.id, booking.start_date, booking.end_date, booking.room.hotel.name, booking.room.room_type.name, booking.room.room_type.price, booking.user.name, booking.status ,booking.created_at, booking.updated_at]
        csv << booking.attributes.values_at(*attribute_names)
      end
    end
  end

  desc "Generate the CSV file for room model"
  task rooms_csv: :environment do
    require 'csv'

    csv_file_path = Rails.root.join('csv-file','room-csv' ,"rooms-list-#{Date.today}.csv")

    rooms = Room.all

    # attribute_names = ["Room number", "Type", "Description", "Hotel-name", "Price /day", "Capacity", "Status", "Created_at", "Updated-at" ]
    attribute_names = Room.attribute_names
    
    CSV.open(csv_file_path, "wb",headers: attribute_names) do |csv|
      csv << attribute_names

      rooms.each do |room|
        csv << room.attributes.values_at(*attribute_names)
        # csv << [room.room_number, room.room_type.name, room.room_type.description, room.hotel.name, room.room_type.price, room.room_type.capacity, room.status, room.created_at, room.updated_at]
      end
    end
  end

  desc "Generate the CSV file for room_type model"
  task room_types_csv: :environment do
    require 'csv'

    csv_file_path = Rails.root.join('csv-file','room_type-csv' ,"room_types-list-#{Date.today}.csv")

    room_types = RoomType.all

    # attribute_names = ["Name", "Description", "Hotel-name", "Price /day", "Capacity", "Created_at", "Updated-at" ]
    attribute_names = RoomType.attribute_names
    CSV.open(csv_file_path, "wb",headers: attribute_names) do |csv|
      csv << attribute_names

      room_types.each do |room_type|
        csv << room_type.attributes.values_at(*attribute_names)
        # csv << [room_type.name, room_type.description, room_type.hotel.name, room_type.price, room_type.capacity, room_type.created_at, room_type.updated_at]
      end
    end
  end

  desc "Generate the CSV file for room_type model"
  task services_csv: :environment do
    require 'csv'

    csv_file_path = Rails.root.join('csv-file','service-csv' ,"servises-list-#{Date.today}.csv")

    services = Service.all

    # attribute_names = ["Name", "Description", "Hotel-name", "Created_at", "Updated-at" ]
    attribute_names = Service.attribute_names
    CSV.open(csv_file_path, "wb",headers: attribute_names) do |csv|
      csv << attribute_names

      services.each do |service|
        csv << service.attributes.values_at(*attribute_names)
        # csv << [service.name, service.description, service.hotel.name, service.created_at, service.updated_at]
      end
    end
  end

  desc "Generate the CSV file for room_type model"
  task payments_csv: :environment do
    require 'csv'

    csv_file_path = Rails.root.join('csv-file','payment-csv' ,"payments-list-#{Date.today}.csv")

    payments = Payment.all

    # attribute_names = ["Card_holder_name", "Card_number", "Bank_name", "Amount", "Payment_date", "Room-name", "Hotel-name", "Created_at", "Updated-at" ]
    attribute_names = Payment.attribute_names
    CSV.open(csv_file_path, "wb",headers: attribute_names) do |csv|
      csv << attribute_names

      payments.each do |payment|
        csv << payment.attributes.values_at(*attribute_names)
        # csv << [payment.card_holder_name, payment.card_number, payment.bank_name, payment.amount, payment.payment_date, payment.booking.room.room_type.name, payment.booking.room.hotel.name, payment.created_at, payment.updated_at]
      end
    end
  end


end
