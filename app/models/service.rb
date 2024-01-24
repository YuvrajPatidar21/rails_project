class Service < ApplicationRecord
  belongs_to :hotel
  has_one_attached :service_picture
  
  validates :name, presence: true
  validates, description: true, length: {minimum: 50}
  
end
