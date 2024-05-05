require 'rails_helper'

RSpec.describe 'Customer subscriptions' do
  it 'retrieves all subscriptions for a specific customer' do
    black_tea = FactoryBot.create(:tea, title: "Black Tea")
    mint_tea = FactoryBot.create(:tea, title: "Mint Tea")
    customer = FactoryBot.create(:customer, email: "keoki@love.com")
    sub = Subscription.create!(title: "Starter Subscription", price: 20.99, frequency: 30) 
    customer_subscription_1 = CustomerSubscription.create!(customer_id: customer.id, subscription_id: sub.id, tea_id: black_tea.id)
    customer_subscription_2 = CustomerSubscription.create!(status: 1, customer_id: customer.id, subscription_id: sub.id, tea_id: mint_tea.id)

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful

    customer_response = JSON.parse(response.body, symbolize_names: true)

    expect(customer_response[:data]).to be_a Hash
    expect(customer_response[:data][:id]).to eq("#{customer.id}")
    expect(customer_response[:data][:type]).to eq("customer")
    expect(customer_response[:data]).to have_key(:attributes)
    expect(customer_response[:data][:attributes]).to have_key(:customer_subscriptions)
    expect(customer_response[:data][:attributes][:customer_subscriptions]).to be_an Array
    
    customer_subs = customer_response[:data][:attributes][:customer_subscriptions]
    expect(customer_subs.count).to eq(2)
    expect(customer_subs.first[:status]).to eq("Active")
    expect(customer_subs.last[:status]).to eq("Cancelled")
  end

  it 'returns an error if customer does not exist' do
    get "/api/v1/customers/12"

    expect(response.status).to eq(404)

    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(error_response[:errors]).to be_an Array
    expect(error_response[:errors].first).to be_a Hash
    expect(error_response[:errors].first[:detail]).to eq("Couldn't find Customer with 'id'=12")
  end
end