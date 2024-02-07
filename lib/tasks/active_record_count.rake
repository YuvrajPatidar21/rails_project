namespace :active_record_count do
  desc "TODO"
  task hotel_count: :environment do
    puts "Hotel count: #{Hotel.count}"
  end

  desc "TODO"
  task user_count: :environment do
    puts "User count: #{User.count}"
  end

  desc "TODO"
  task room_count: :environment do
    puts "Room count: #{Room.count}"
  end

  desc "TODO"
  task booking_count: :environment do
    puts "Booking count: #{Booking.count}"
  end

  desc "TODO"
  task payment_count: :environment do
    puts "Payment count: #{Payment.count}"
  end

end
