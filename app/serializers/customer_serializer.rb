class CustomerSerializer
  include JSONAPI::Serializer
  attributes :customer_subscriptions
end
