class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :validatable,
         :confirmable,
         :trackable

  
  validates :name, presence: true, uniqueness: true, length: {minimum: 3}
  validates :email, presence: true, uniqueness: true
  validates :mobile, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 10 }
  validates :address, presence: true
  validates :date_of_birth, presence: true
  validates :date_of_birth, presence: true
  validate :validate_date_of_birth
  validates :status, presence: true
  validates :city, presence: true
  
  validates :zipcode, presence: true, numericality: { only_integer: true}

  enum role: [:user, :manager, :admin]
    
  after_initialize :set_default_role, if: :new_record?
              
  def set_default_role
    self.role ||= :user
  end    

  private
  def after_confirmation
    WelcomeMailer.send_greetings_notification(self)
                 .deliver_now
  end
  def validate_date_of_birth
    if date_of_birth.present? && date_of_birth > Date.current 
      errors.add(:date_of_birth, 'must be in the past')
    end
  end

end
