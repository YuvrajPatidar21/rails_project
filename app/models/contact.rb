class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP
  validates :subject, presence: true, length: { minimum: 20 }
  validates :message, presence: true, length: { minimum:40 }
end
