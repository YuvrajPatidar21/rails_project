class SendMorningMailJob
  include Sidekiq::Job

  def perform
    User.find_each do |user|
    puts "###############################################################"
      WelcomeMailer.send_morning_wises(user).deliver_now
      # DailyMailer.send_daily_email(user).deliver_now
    end
  end
end
