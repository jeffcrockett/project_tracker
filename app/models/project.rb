class Project < ApplicationRecord
  belongs_to :distributor
  belongs_to :company
  validates :name, presence:true
end
