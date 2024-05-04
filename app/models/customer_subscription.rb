class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription
  belongs_to :tea

  enum status: {
  Active: 0,
  Cancelled: 1
  }
end
