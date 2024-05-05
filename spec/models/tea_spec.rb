require 'rails_helper'

RSpec.describe Tea, type: :model do
  it {should have_many :customer_subscriptions}
end
