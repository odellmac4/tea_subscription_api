class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    customer_subscription = CustomerSubscription.new(customer_subscription_params)

    if customer_subscription.save!
      render json: CustomerSubscriptionSerializer.new(customer_subscription, new_subscription_tea_data).serialize_json, status: :created
    end
  end

  def update
    customer_subscription = CustomerSubscription.find(params[:id])
    subscription_tea_data = existing_subscription_tea_data(customer_subscription)
    
    if customer_subscription
      customer_subscription.cancel_subscription
      customer_subscription.save!
      render json: CustomerSubscriptionSerializer.new(customer_subscription, subscription_tea_data).serialize_json, status: :ok
    end
  end

  private

  def customer_subscription_params
    params.require(:customer_subscription).permit(:customer_id, :subscription_id, :tea_id)
  end

  def new_subscription_tea_data
    subscription = Subscription.find(params[:subscription_id])
    tea = Tea.find(params[:tea_id])

    data = {subscription: subscription, tea: tea}
  end

  def existing_subscription_tea_data(customer_subscription)
    subscription = Subscription.find_by(id: customer_subscription.subscription_id)
    tea = Tea.find_by(id: customer_subscription.tea_id)

    data = {subscription: subscription, tea: tea}
  end
end
