class Product < ApplicationRecord
  validates :name, presence:true
  validates :price, numericality:true
  validates :cogs, numericality:true
end
