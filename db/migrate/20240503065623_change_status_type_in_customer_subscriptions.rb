class ChangeStatusTypeInCustomerSubscriptions < ActiveRecord::Migration[7.1]
  def change
    remove_column :customer_subscriptions, :status
    add_column :customer_subscriptions, :status, :integer, null: false, default: 0
  end
end
