class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    customer_subscription = CustomerSubscription.new(customer_subscription_params)

    if customer_subscription.save!
      render json: CustomerSubscriptionSerializer.new(customer_subscription, subscription_tea_data).serialize_json, status: :created
    end
  end

  private

  def customer_subscription_params
    params.require(:customer_subscription).permit(:customer_id, :subscription_id, :tea_id)
  end

  def subscription_tea_data
    subscription = Subscription.find(params[:subscription_id])
    tea = Tea.find(params[:tea_id])

    data = {subscription: subscription, tea: tea}
  end
end
