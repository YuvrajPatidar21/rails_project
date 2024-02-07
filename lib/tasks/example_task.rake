namespace :example_task do
  desc "Greetig message"

  task greet_the_user: :environment do
    puts "Greet the message to user"
  end

  task say_bye_to_user: :environment do
    puts "Say bye to user"
  end
end