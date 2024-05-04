require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  before(:each) do
    black_tea = FactoryBot.create(:tea, title: "Black Tea")

    customer_1 = FactoryBot.create(:customer)

    thirty_day = Subscription.create!(title: "Starter Subscription", price: 20.99, frequency: 30) 
    sixty_day = Subscription.create!(title: "Silver Subscription", price: 40.99, frequency: 60)

    @customer_subscription1 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: thirty_day.id, tea_id: black_tea.id)
    @customer_subscription8 = CustomerSubscription.create!(status: 1, customer_id: customer_1.id, subscription_id: sixty_day.id, tea_id: black_tea.id)
  end
  it {should belong_to :customer}
  it {should belong_to :subscription}
  it {should belong_to :tea}

  it 'has a default status of active' do

    expect(@customer_subscription1.status).to eq("Active")
    expect(@customer_subscription8.status).to eq("Cancelled")
  end

  it '#cancel_subscription' do
    @customer_subscription1.cancel_subscription

    expect(@customer_subscription1.status).to eq("Cancelled")
  end
end
