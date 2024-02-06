class WelcomeMailer < ApplicationMailer
  def send_greetings_notification(user)
    @user = user

    mail to: @user.email, subject: 'Thank you for signing up on our site'
  end

  def send_morning_wises(user)
    @user = user
    mail to: @user.email, subject: 'Good morning! Have a nice day'
  end
end
