class CreateCustomerSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :customer_subscriptions do |t|
      t.string :status
      t.references :customer, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
