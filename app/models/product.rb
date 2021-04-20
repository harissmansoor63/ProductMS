class Product < ApplicationRecord
  validates :title, :price, :description, :status, presence: true 
  # validates :status, inclusion: {in: %w(Publish Draft Pending), message: "%{value} is not a valid blah blah"}
  STATUS_ENUM = { Publish: 1, Draft: 2, Pending: 3 } 
  enum status: STATUS_ENUM
end
