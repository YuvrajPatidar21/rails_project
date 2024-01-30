class Service < ApplicationRecord
  belongs_to :hotel
  has_one_attached :service_picture
  
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 50}

  before_save do
    self.name = name.titleize
    self.description = description.capitalize
  end
  
end
