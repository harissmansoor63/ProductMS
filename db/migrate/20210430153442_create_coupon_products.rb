class CreateCouponProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_products do |t|
      t.references :coupon, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
