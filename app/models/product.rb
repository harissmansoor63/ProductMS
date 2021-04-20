class Product < ApplicationRecord
  validates :title, :price, :description, :status, presence: true 
  STATUS_ENUM = { Publish: 1, Draft: 2, Pending: 3 } 
  enum status: STATUS_ENUM
end
