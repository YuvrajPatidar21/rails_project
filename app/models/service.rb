class Service < ApplicationRecord
  belongs_to :hotel
  has_one_attached :service_picture
end
