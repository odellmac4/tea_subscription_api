require 'rails_helper'

RSpec.describe 'Create a new subscription' do
  before(:each) do
    @black_tea = FactoryBot.create(:tea, title: "Black Tea")
    @customer = FactoryBot.create(:customer)
    @sub = Subscription.create!(title: "Starter Subscription", price: 20.99, frequency: 30) 
  end

  it 'creates new subscription along with details' do
    customer_sub_params = {
      "customer_id": @customer.id,
      "subscription_id": @sub.id,
      "tea_id": @black_tea.id
    }

    post '/api/v1/customer_subscriptions', params: customer_sub_params.to_json, headers: { 'Content-Type' => 'application/json' }
    
    expect(response).to have_http_status(:created)
    
    created_sub_response = JSON.parse(response.body, symbolize_names: true)

    expect(created_sub_response[:data]).to be_a Hash
    expect(created_sub_response[:data]).to have_key (:id)
    expect(created_sub_response[:data]).to have_key (:customer_id)
    expect(created_sub_response[:data][:customer_id]).to eq(@customer.id)
    expect(created_sub_response[:data]).to have_key (:type)
    expect(created_sub_response[:data][:type]).to eq ("customer subscription")
    expect(created_sub_response[:data]).to have_key (:subscription)
    expect(created_sub_response[:data][:subscription]).to have_key (:type)
    expect(created_sub_response[:data][:subscription]).to have_key (:price)
    expect(created_sub_response[:data][:subscription]).to have_key (:frequency)
    expect(created_sub_response[:data][:subscription]).to have_key (:status)
    expect(created_sub_response[:data][:subscription][:status]).to eq ("Active")
    expect(created_sub_response[:data][:subscription]).to have_key (:tea)
    expect(created_sub_response[:data][:subscription][:tea]).to eq ("Black Tea")
  end
end