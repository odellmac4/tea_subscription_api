class CustomerSubscriptionSerializer
  def initialize(customer_subscription, subscription_tea_data)
    @customer_subscription = customer_subscription
    @subscription = subscription_tea_data[:subscription]
    @tea = subscription_tea_data[:tea]
  end

  def serialize_json
    {
      data:{
        id: @customer_subscription.id,
        customer_id: @customer_subscription.customer_id,
        type: "customer subscription",
        subscription: {
          status: @customer_subscription.status,
          tea: @tea.title,
          type: @subscription.title,
          price: @subscription.price,
          frequency: @subscription.frequency,
        }
      }
    }
  end
end
