# db/seeds.rb

require 'faker'

# Clear existing records
User.destroy_all
Product.destroy_all
Order.destroy_all
OrderItem.destroy_all

# Create users
user1 = User.create!(
  email: 'user1@example.com',
  password: 'password',
  password_confirmation: 'password'
)

user2 = User.create!(
  email: 'user2@example.com',
  password: 'password',
  password_confirmation: 'password'
)

puts "Created #{User.count} users"

# Create products
10.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price(range: 10.0..100.0),
    stock: Faker::Number.between(from: 1, to: 100),
    image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['product']),
    user: [user1, user2].sample
  )
end

puts "Created #{Product.count} products"

# Create orders
3.times do
  order = Order.create!(
    user: [user1, user2].sample,  # Ensure the user exists
    total_price: Faker::Commerce.price(range: 30.0..200.0),
    status: 'pending'
  )

  # Create order items
  2.times do
    product = Product.order('RANDOM()').first
    OrderItem.create!(
      order: order,
      product: product,
      quantity: Faker::Number.between(from: 1, to: 5),
      unit_price: product.price
    )
  end
end

puts "Created #{Order.count} orders with #{OrderItem.count} order items"

# Output seed data
puts "Seeding completed!"
