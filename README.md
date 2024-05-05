# Tea Subscription API 🍵

The Tea Subscription API exposes data for frontend develpoers to create and update tea subscriptions for customers. The endpoints developed include:
1. [subscribe a customer to a tea subscription](#create-customer-subscription)
2. [cancel a customer’s tea subscription](#cancel-customer-subscription)
3. [customer’s subsciptions (active and cancelled)](#customer-subscriptions)

# Database Schema
```
create_table "customer_subscriptions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "subscription_id", null: false
    t.bigint "tea_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["customer_id"], name: "index_customer_subscriptions_on_customer_id"
    t.index ["subscription_id"], name: "index_customer_subscriptions_on_subscription_id"
    t.index ["tea_id"], name: "index_customer_subscriptions_on_tea_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.float "price"
    t.integer "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.float "temperature"
    t.float "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customer_subscriptions", "customers"
  add_foreign_key "customer_subscriptions", "subscriptions"
  add_foreign_key "customer_subscriptions", "teas"
end
```

# Endpoints

### Create customer subscription
Details: 

1. This endpoint should follow the pattern of `POST /api/v1/customer_subscriptions` and `customer_id`, `subscription_id`, and `tea_id` must be included in the body of the request. It should then return a new customer subscription.
2. An error should be returned if any of the attributes do not exist in the database or all of the appropriate attributes are not passed in the body of the request.

Example [#1] 😁

Request: 
```
POST /api/v1/customer_subscriptions

body: {
      "customer_id": 5,
      "subscription_id": 1,
      "tea_id": 4
    }
Content-Type: application/json
```
Response: `status: 201`

```
{
    "data": {
        "id": 29,
        "customer_id": 5,
        "type": "customer subscription",
        "subscription": {
            "status": "Active",
            "tea": {
                "id": 4,
                "title": "Lavender Tea",
                "description": "Porro dolores cupiditate ut.",
                "temperature": 90.0,
                "brew_time": 80.0
            },
            "type": "Starter Subscription",
            "price": 20.99,
            "frequency": 30
        }
    }
}
```
Example [#2] 😞 

Request:
```
POST /api/v1/customer_subscriptions

body: {
      "customer_id": 5
    }
Content-Type: application/json
```
Response: `status: 400`
```
{
    "errors": [
        {
            "detail": "Validation failed: Subscription can't be blank, Tea can't be blank, Subscription must exist, Tea must exist"
        }
    ]
}
```

### Cancel customer subscription
Details:
1. This endpoint should follow the pattern of `PATCH "/api/v1/customer_subscriptions/:id"`

2. If a valid customer subscription id is passed in, a JSON object is sent back where the customer subscription status should read "Cancelled"

3. If an invalid customer subscription id is passed in, a 404 status as well as a descriptive error message shouuld be sent back in response.

Example [#1] 😁

Request: 
```
PATCH "/api/v1/customer_subscriptions/11
Content-Type: application/json
```
Response: `status: 200`
```
{
    "data": {
        "id": 11,
        "customer_id": 1,
        "type": "customer subscription",
        "subscription": {
            "status": "Cancelled",
            "tea": {
                "id": 3,
                "title": "Mint Tea",
                "description": "Explicabo voluptatem similique iure.",
                "temperature": 80.0,
                "brew_time": 78.0
            },
            "type": "Silver Subscription",
            "price": 40.99,
            "frequency": 60
        }
    }
}
```

Example [#2] 😞 

Request:
```
PATCH "/api/v1/customer_subscriptions/20
Content-Type: application/json
```
Response: `status: 404`
```
{
    "errors": [
        {
            "detail": "Couldn't find CustomerSubscription with 'id'=20"
        }
    ]
}
```
### Customer subscriptions
Details:

Retrieve all of a customer's subscriptions(active and cancelled).
1. This endpoint should follow the pattern `GET "/api/v1/customers/:id"`
2. If an invalid customer id is passed in, a 404 status as well as a descriptive error message shouuld be sent back in response.

Example [#1] 😁

Request: 
```
GET /api/v1/customers/5
Content-Type: application/json
```
Response: `status: 200`
```
{
    "data": {
        "id": "5",
        "type": "customer",
        "attributes": {
            "customer_subscriptions": [
                {
                    "id": 5,
                    "customer_id": 5,
                    "subscription_id": 3,
                    "tea_id": 3,
                    "created_at": "2024-05-03T07:02:13.464Z",
                    "updated_at": "2024-05-03T07:02:13.464Z",
                    "status": "Active"
                },
                {
                    "id": 10,
                    "customer_id": 5,
                    "subscription_id": 1,
                    "tea_id": 1,
                    "created_at": "2024-05-03T07:02:13.485Z",
                    "updated_at": "2024-05-03T07:02:13.485Z",
                    "status": "Cancelled"
                }
            ]
        }
    }
}
```
Example [#2] 😞 

Request:
```
GET /api/v1/customers/100
Content-Type: application/json
```
Response: `status: 404`
```
{
    "errors": [
        {
            "detail": "Couldn't find Customer with 'id'=100"
        }
    ]
}
```
