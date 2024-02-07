class WelcomeMailer < ApplicationMailer
  def send_greetings_notification(user)
    @user = user

    mail to: @user.email, subject: 'Thank you for signing up on our site'
  end

  def send_morning_mail(user)
    @user = user
    mail to: @user.email, subject: 'Very Good Morning!, Have a nice day'
  end
end
