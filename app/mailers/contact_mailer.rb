class ContactMailer < ApplicationMailer
  
  def contact_email(contact)
    @contact = contact
    mail(from: @contact.email, to: "hotel@example.org",
         subject: 'New Contact email form #{@contact.email}')
  end
end
