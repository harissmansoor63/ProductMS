class Product < ApplicationRecord
  has_many :coupon_products, dependent: :destroy
  has_many :coupons, through: :coupon_products
  has_one_attached :image
  has_many :order_items, dependent: :destroy

  validates :title, :price, :description, :status, presence: true

  STATUS_ENUM = { Publish: 1, Draft: 2, Pending: 3 } 

  enum status: STATUS_ENUM

  HEADERS = ['Title', 'Price', 'Status', 'Description']

  ADMIN_PRODUCT_PERPAGE = 5
  USER_PRODUCT_PERPAGE = 10

  def self.search(search)
    return all if search.blank?
    where('title LIKE :value OR price LIKE :value OR id LIKE :value', { value: search })
  end
end
