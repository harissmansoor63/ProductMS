class AddAddressToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :address, :string
    add_column :orders, :payment_information, :string
  end
end
