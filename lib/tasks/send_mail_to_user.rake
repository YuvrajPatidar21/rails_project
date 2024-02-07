namespace :send_mail_to_user do
  desc "TODO"
  task send_mail: :environment do
    User.find_each do |user|
      WelcomeMailer.send_greetings_notification(user).deliver_now
    end
  end

end
