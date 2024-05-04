require 'rails_helper'

RSpec.describe 'Cancel customer subscription' do
  
  it 'changes customer subscription status to be cancelled' do
    black_tea = FactoryBot.create(:tea, title: "Black Tea")
    customer = FactoryBot.create(:customer, email: "dream@dreams.com")
    sub = Subscription.create!(title: "Starter Subscription", price: 20.99, frequency: 30) 
    customer_subscription = CustomerSubscription.create!(customer_id: customer.id, subscription_id: sub.id, tea_id: black_tea.id)

    #decided to use patch since the third enpoint requires a customer
    #subscription to persist in the database

    patch "/api/v1/customer_subscriptions/#{customer_subscription.id}"

    expect(response).to be_successful

    cancelled_sub_response = JSON.parse(response.body, symbolize_names: true)

    expect(cancelled_sub_response[:data]).to be_a Hash
    expect(cancelled_sub_response[:data]).to have_key (:id)
    expect(cancelled_sub_response[:data]).to have_key (:customer_id)
    expect(cancelled_sub_response[:data][:customer_id]).to eq(customer.id)
    expect(cancelled_sub_response[:data]).to have_key (:type)
    expect(cancelled_sub_response[:data][:type]).to eq ("customer subscription")
    expect(cancelled_sub_response[:data]).to have_key (:subscription)
    expect(cancelled_sub_response[:data][:subscription]).to have_key (:type)
    expect(cancelled_sub_response[:data][:subscription]).to have_key (:price)
    expect(cancelled_sub_response[:data][:subscription]).to have_key (:frequency)
    expect(cancelled_sub_response[:data][:subscription]).to have_key (:status)
    expect(cancelled_sub_response[:data][:subscription][:status]).to eq ("Cancelled")
    expect(cancelled_sub_response[:data][:subscription]).to have_key (:tea)
    expect(cancelled_sub_response[:data][:subscription][:tea]).to eq ("Black Tea")
  end
end