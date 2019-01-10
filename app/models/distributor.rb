class Distributor < ApplicationRecord
    validates :name, presence:true, uniqueness:true
end
