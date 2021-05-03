class Coupon < ApplicationRecord
  has_many :coupon_products, dependent: :destroy
  has_many :products, through: :coupon_products
  validates :title, :discount, presence: true

  HEADERS = ['Title', 'Discount']

  ADMIN_COUPON_PERPAGE = 5

  def self.search(search)
    return all if search.blank?
    where('title LIKE :value OR discount LIKE :value OR id LIKE :value', {value: search})
  end
end
