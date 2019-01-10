class Shipment < ApplicationRecord
  belongs_to :project
  belongs_to :product
  validates :name, presence:true, uniqueness:true
end
