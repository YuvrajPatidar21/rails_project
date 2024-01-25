class ContactMailer < ApplicationMailer
  
  def contact_email(contact)
    @contact = contact
    mail(from: @contact.email, to: ENV['SMTP_USERNAME'],
         subject: 'New Contact email form #{@contact.email}')
  end
end
