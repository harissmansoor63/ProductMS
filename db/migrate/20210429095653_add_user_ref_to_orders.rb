class AddUserRefToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :user, foreign_key: true
    add_column :orders, :confirmation, :boolean, default: false
  end
end
