require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it {should have_many :customer_subscriptions}
end
