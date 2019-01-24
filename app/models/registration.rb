class Registration < ApplicationRecord
  belongs_to :project
  validates :expiration, presence: true
end