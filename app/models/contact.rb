class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP
  validates :subject, presence: true, length: { minimum: 20 }
  validates :message, presence: true, length: { minimum:40 }

  before_save do 
    self.name = name.titleize
    self.subject = subject.titleize
    self.message = message.capitalize
  end
end
