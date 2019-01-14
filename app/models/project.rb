class Project < ApplicationRecord
  belongs_to :distributor
  belongs_to :company
  has_many :shipments, dependent: :destroy
  has_many :registrations, dependent: :destroy
  validates :name, presence:true
end
