class RemoveNameFromCoupons < ActiveRecord::Migration[5.2]
  def change
    remove_column :coupons, :name, :string
    remove_column :coupons, :value, :decimal
  end
end
