class Coupon < ApplicationRecord
  belongs_to :product
  validates :title, :discount, presence: true

  HEADERS = ['Title', 'Discount']

  def self.search(search)
    return all if search.blank?
    where('title LIKE :value OR discount LIKE :value OR id LIKE :value', {value: search})
  end
end
