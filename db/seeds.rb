# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
thirty_day = Subscription.create!(title: "Starter Subscription", price: 20.99, frequency: 30) 
sixty_day = Subscription.create!(title: "Silver Subscription", price: 40.99, frequency: 60) 
ninety_day = Subscription.create!(title: "Premium Subscription", price: 60.99, frequency: 90)

customer_1 = FactoryBot.create(:customer)
customer_2 = FactoryBot.create(:customer)
customer_3 = FactoryBot.create(:customer)
customer_4 = FactoryBot.create(:customer)
customer_5 = FactoryBot.create(:customer)

black_tea = FactoryBot.create(:tea, title: "Black Tea")
green_tea = FactoryBot.create(:tea, title: "Green Tea")
mint_tea = FactoryBot.create(:tea, title: "Mint Tea")
lavender_tea = FactoryBot.create(:tea, title: "Lavender Tea")

customer_subscription1 = CustomerSubscription.create!(status: 0, customer_id: customer_1.id, subscription_id: thirty_day.id, tea_id: black_tea.id)
customer_subscription2 = CustomerSubscription.create!(status: 0, customer_id: customer_2.id, subscription_id: thirty_day.id, tea_id: black_tea.id)
customer_subscription3 = CustomerSubscription.create!(status: 0, customer_id: customer_3.id, subscription_id: sixty_day.id, tea_id: green_tea.id)
customer_subscription4 = CustomerSubscription.create!(status: 0, customer_id: customer_4.id, subscription_id: sixty_day.id, tea_id: mint_tea.id)
customer_subscription5 = CustomerSubscription.create!(status: 0, customer_id: customer_5.id, subscription_id: ninety_day.id, tea_id: mint_tea.id)
customer_subscription6 = CustomerSubscription.create!(status: 1, customer_id: customer_1.id, subscription_id: ninety_day.id, tea_id: lavender_tea.id)
customer_subscription7 = CustomerSubscription.create!(status: 1, customer_id: customer_2.id, subscription_id: ninety_day.id, tea_id: lavender_tea.id)
customer_subscription8 = CustomerSubscription.create!(status: 1, customer_id: customer_3.id, subscription_id: sixty_day.id, tea_id: mint_tea.id)
customer_subscription9 = CustomerSubscription.create!(status: 1, customer_id: customer_3.id, subscription_id: sixty_day.id, tea_id: black_tea.id)
customer_subscription10 = CustomerSubscription.create!(status: 1, customer_id: customer_5.id, subscription_id: thirty_day.id, tea_id: black_tea.id)