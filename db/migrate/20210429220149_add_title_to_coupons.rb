class AddTitleToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :title, :string
    add_column :coupons, :discount, :decimal
  end
end
