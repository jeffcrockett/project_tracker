class Project < ApplicationRecord
  belongs_to :distributor
  validates :name, presence:true, uniqueness:true
end
