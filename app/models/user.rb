class User < ApplicationRecord
  has_and_belongs_to_many :hotels
  has_one_attached :profile_picture
  has_many :bookings, dependent: :destroy
  has_many :rooms, through: :bookings, dependent: :destroy
  has_many :payments, through: :bookings, dependent: :destroy

  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :validatable

  validates :name, presence: true, length: {minimum: 3}
  validates :email, presence: true, uniqueness: true
  validates :email, format:  URI::MailTo::EMAIL_REGEXP
  validates :mobile, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 10 }
  validates :address, presence: true
  validates :date_of_birth, presence: true
  validate :validate_date_of_birth
  validates :status, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: { only_integer: true}, length: { is: 6}
  
  after_create do
    WelcomeMailer.send_greetings_notification(self).deliver_now
  end
  before_save do
    self.name = name.titleize
    self.address = address.titleize
    self.city = city.titleize
    self.state = state.titleize
  end
  enum role: [:customer, :manager, :admin]
    
  after_initialize :set_default_role, if: :new_record?
              
  def set_default_role
    self.role ||= :customer
  end    

  private

    def validate_date_of_birth
      if date_of_birth.present? && date_of_birth > Date.current 
        errors.add(:date_of_birth, 'must be in the past')
      end
    end
end
