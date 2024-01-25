class Hotel < ApplicationRecord
  has_and_belongs_to_many :users, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :room_types, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :bookings, through: :rooms
  has_many :payments, through: :bookings
  has_many_attached :hotel_pictures

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validates :telephone, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 10 }
  validates :location, presence: true, uniqueness: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: { only_integer: true}, length: { is: 6 }
  validates :description, presence: true

end
