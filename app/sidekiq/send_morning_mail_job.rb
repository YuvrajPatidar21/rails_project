class SendMorningMailJob
  include Sidekiq::Job

  def perform
    User.find_each do |user|
      WelcomeMailer.send_morning_mail(user).deliver_now
    end
  end
end
