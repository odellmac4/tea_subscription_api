class CustomerSubscription < ApplicationRecord
  validates :customer_id, presence: true
  validates :subscription_id, presence: true
  validates :tea_id, presence: true

  belongs_to :customer
  belongs_to :subscription
  belongs_to :tea

  enum status: {
  Active: 0,
  Cancelled: 1
  }

  def cancel_subscription
    self.status = 1
  end
end
