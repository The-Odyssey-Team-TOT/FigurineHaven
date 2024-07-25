require 'faker'

# Clear existing records (except users)
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all

# Existing users
user1 = User.find_by(email: 'user1@example.com')
user2 = User.find_by(email: 'user2@example.com')

if user1.nil?
  user1 = User.create!(
    email: 'user1@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
end

if user2.nil?
  user2 = User.create!(
    email: 'user2@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
end

puts "Using #{User.count} users"

# Star Wars figurines data
star_wars_figurines = [
  { name: "Darth Vader", description: "@  Dark Lord of the Sith", price: 49.99, image_url: "https://m.media-amazon.com/images/I/71rLfcUenIL._AC_SY879_.jpg" },
  { name: "Luke Skywalker", description: "@  Jedi Knight and hero of the Rebellion", price: 39.99, image_url: "https://m.media-amazon.com/images/I/51CaaKMtr-L.__AC_SX300_SY300_QL70_ML2_.jpg" },
  { name: "Princess Leia", description: "@  Princess of Alderaan and leader of the Rebel Alliance  @", price: 35.99, image_url: "https://m.media-amazon.com/images/I/91LuPIdD2NL._AC_SY879_.jpg" },
  { name: "Han Solo", description: "@  Smuggler and hero of the Rebellion", price: 45.99, image_url: "https://m.media-amazon.com/images/I/81wH0Ss3iUL._AC_SX679_.jpg" },
  { name: "Stormtrooper", description: "@  Imperial Stormtrooper from the Galactic Empire", price: 29.99, image_url: "https://m.media-amazon.com/images/I/71ApcYwWHZL._AC_SX679_.jpg" },
  { name: "Obi-Wan Kenobi", description: "@  Jedi Master and mentor to Luke Skywalker", price: 42.99, image_url: "https://m.media-amazon.com/images/I/61QDzWDLY+L._AC_SY300_SX300_.jpg" },
  { name: "Boba Fett", description: "@  Infamous bounty hunter", price: 44.99, image_url: "https://m.media-amazon.com/images/I/81uN5oc6VVL._AC_SX679_.jpg" },
  { name: "Chewbacca", description: "@  Wookiee and co-pilot of the Millennium Falcon", price: 38.99, image_url: "https://m.media-amazon.com/images/I/71E2jBtbIOL.__AC_SX300_SY300_QL70_ML2_.jpg" },
  { name: "R2-D2", description: "@  Astromech droid and companion to many heroes", price: 34.99, image_url: "https://m.media-amazon.com/images/I/61HnWU3NGIL.__AC_SX300_SY300_QL70_ML2_.jpg" },
  { name: "C-3PO", description: "@  Protocol droid fluent in over six million forms of communication", price: 34.99, image_url: "https://m.media-amazon.com/images/I/71nWjkRJk1L.__AC_SX300_SY300_QL70_ML2_.jpg" },
  { name: "Bib Fortuna", description: "@  Advisor to Jabba the Hutt and a Twi'lek from Ryloth", price: 24.99, image_url: "https://m.media-amazon.com/images/I/71L7JQlZ-fL._AC_SX679_.jpg" },
  { name: "Reva", description: "@  Third Sister of the Inquisitorius, hunting down Jedi", price: 34.99, image_url: "https://m.media-amazon.com/images/I/51r-x5PO4bL._AC_SX679_.jpg" },
  { name: "Mandalorian", description: "@  Mandalorian Super Commando, a fierce warrior", price: 29.99, image_url: "https://m.media-amazon.com/images/I/61+usPy+B9L._AC_SX679_.jpg" },
  { name: "Tusken Warrior", description: "@  Fierce warriors from the deserts of Tatooine", price: 14.99, image_url: "https://m.media-amazon.com/images/I/61vK+X22MRL._AC_SX679_.jpg" },
  { name: "Artillery Stormtrooper", description: "@  Specialized trooper for heavy artillery in the Empire", price: 37.99, image_url: "https://m.media-amazon.com/images/I/61whEGzD7CL._AC_SX679_.jpg" },
  { name: "Shae Vizla", description: "@  Mandalorian bounty hunter and mercenary", price: 23.99, image_url: "https://m.media-amazon.com/images/I/61+-e8rxeuL._AC_SX679_.jpg" },
  { name: "VIN Las Vegas", description: "@  Star Wars The Vintage Collection - HSF9779 - Figurine articulée 10cm - Figures Captain Rex (Bracca Mission)", price: 23.99, image_url: "https://m.media-amazon.com/images/I/71QEjVyvivL._AC_SX679_.jpg" },
  { name: "Figures Captain Rex", description: "@  Star Wars The Vintage Collection - HSF9779 - Star Wars Hasbro SW VIN Las Vegas, F4462, Multicolore)", price: 23.99, image_url: "https://m.media-amazon.com/images/I/71l1Cf1+HEL._AC_SX679_.jpg" },
  { name: "Luke Skywalker (Hoth Attack)", description: "@  Star Wars The Vintage Collection - HSF9779 - Star Wars Luke Skywalker (Hoth Attack) Figure - Empire Strikes Back", price: 23.99, image_url: "https://m.media-amazon.com/images/I/71YLACxnIDL._AC_SX679_.jpg" },
  { name: "Biker Scout", description: "@  Star Wars Hasbro F7074 The Black Series, Biker Scout, Figurine de 15 cm, Le Retour du Jedi", price: 23.99, image_url: "https://m.media-amazon.com/images/I/815EGf8zpML._AC_SX679_.jpg" },
  { name: "Lando Calrissian (Skiff Guard)", description: "@  Star Wars Hasbro Retro Collection, Lando Calrissian (Skiff Guard), Le Retour du Jedi, Figurine de Collection, échelle de 9,5 cm, dès 4 Ans, F7277, Multicolore", price: 23.99, image_url: "https://m.media-amazon.com/images/I/61XDPzYR5LL._AC_SX679_.jpg" },
  { name: "Ahsoka Tano", description: "@  Star Wars The Vintage Collection - HSF9779 Star Wars Hasbro Retro Collection Ahsoka Tano", price: 23.99, image_url: "https://m.media-amazon.com/images/I/511uO2CUf+L._AC_SX679_.jpg" },
  { name: "Princesse Leia (Endor)", description: "@  Star Wars The Vintage Collection Star Wars Hasbro The Black Series, Princesse Leia (Endor), Wars : Le Retour du Jedi, Figurine de 15 cm, F7051", price: 23.99, image_url: "https://m.media-amazon.com/images/I/81QbLG4W3dL._AC_SX679_.jpg" },
  { name: "Luminara Unduli", description: "@  Star Wars The Vintage Collection - HSF9779 - Figurine articulée 10cm - Luminara Unduli", price: 23.99, image_url: "https://m.media-amazon.com/images/I/61syMcpFA7L._AC_SX679_.jpg" },
  { name: "C1-10P", description: "@  Star Wars Retro Collection, Figurine Chopper (C1-10P) de 9,5 cm, Ahsoka", price: 23.99, image_url: "https://m.media-amazon.com/images/I/71PpIvp7zAL._AC_SX679_.jpg" },
  { name: "Teebo", description: "@  Star Wars The Vintage Collection, Teebo, Figurine articulée de 9,5 cm Le Retour du Jedi", price: 23.99, image_url: "https://m.media-amazon.com/images/I/81D--DFYyFL._AC_SX679_.jpg" },
  { name: "Clone Trooper Echo", description: "@  Hasbro Star Wars Clone Wars Clone Trooper Echo Nouvel Emballage Figure", price: 23.99, image_url: "https://m.media-amazon.com/images/I/61w26rcC7yL._AC_SX679_.jpg" },
  { name: "Aayla Secura", description: "@  Star Wars Vintage Collection Clone Wars Aayla Secura Figure 10 cm", price: 23.99, image_url: "https://m.media-amazon.com/images/I/61gMMPrZZuL._AC_SX679_.jpg" },
  { name: "Darth Vader", description: "@  Darth Vader VC115 Star Wars Vintage Collection Action Figure", price: 237.79, image_url: "https://m.media-amazon.com/images/I/71jQrSlIDzL._AC_SY879_.jpg" },
  { name: "Tusken Raider", description: "@  Star Wars The Black Series Credit Collection Tusken Raider - 15 cm", price: 24.99, image_url: "https://m.media-amazon.com/images/I/81LAZBdie7L._AC_SX679_.jpg" },
  { name: "Cara Dune", description: "@  Hasbro Star Wars The Vintage Collection The Mandalorian Cara Dune Toy - Figurine d'action à l'échelle 9,5 cm", price: 110.99, image_url: "https://m.media-amazon.com/images/I/91aQoL4BCaS._AC_SX679_.jpg" },
  { name: "Barriss Offee", description: "@  Hasbro, Figurine Vintage Collection Barriss Offee de Star Wars", price: 36.99, image_url: "https://m.media-amazon.com/images/I/61YyBp3LrwL._AC_SX679_.jpg" },
  { name: "The Armorer", description: "@  Hasbro Figurine The Armorer The Mandalorian Star Wars Black Series 15 cm F28965L00", price: 23.99, image_url: "https://m.media-amazon.com/images/I/61vEBkwHiML._AC_SX679_.jpg" },
  { name: "Droïde Assassin HK-87", description: "@  Star Wars The Black Series, Figurine droïde Assassin HK-87 de 9,5 cm, Star Wars : Ahsoka", price: 23.99, image_url: "https://m.media-amazon.com/images/I/71wy6njjrXL._AC_SX679_.jpg" },
  { name: "Yoda", description: "@  1997 Hasbro Star Wars The Power of the Force Yoda Green Card with Holographic Picture by Hasbro (English Manual)", price: 30.99, image_url: "https://m.media-amazon.com/images/I/51O71frFjmL._AC_.jpg" },
  { name: "Death Star Droid", description: "@  Star Wars Vintage Collection Death Star Droid Figure 10 cm", price: 26.11, image_url: "https://m.media-amazon.com/images/I/61iqHK1LS+L._AC_SX679_.jpg" },
  { name: "Droide de Bataille", description: "@  Hasbro Figurine d'action Droide de Bataille 9,5 cm", price: 22.99, image_url: "https://m.media-amazon.com/images/I/81E-WXxvwZL._AC_SY879_.jpg" },
  { name: "Chanlr Valorum", description: "@  Hasbro Star Wars – Chanlr Valorum Figure", price: 78.42, image_url: "https://m.media-amazon.com/images/I/61cL1DYB8IL._AC_SX679_.jpg" },
  { name: "Rebel Soldier Hoth", description: "@  Star Wars – Edition Collector – Figurine Vintage Rebel Soldier Hoth - 10 cm", price: 18.13, image_url: "https://m.media-amazon.com/images/I/819guCq7waL._AC_SX679_.jpg" },
  { name: "Kenner Chewbacca", description: "@  Hasbro Star Wars Kenner Chewbacca Chewie Life Day 2023 Figurine 9,5 cm", price: 2354.99, image_url: "https://m.media-amazon.com/images/I/61hwIDIVWCL._AC_SX679_.jpg" },
  { name: "General Hera Syndulla", description: "@  Star Wars Retro Collection, Figurine General Hera Syndulla de 9,5 cm, Ahsoka", price: 13.29, image_url: "https://m.media-amazon.com/images/I/81MpSwBKA4L._AC_SX679_.jpg" }
]

# Create Star Wars figurines
star_wars_figurines.each do |fig|
  Product.create!(
    name: fig[:name],
    description: fig[:description],
    price: fig[:price],
    stock: Faker::Number.between(from: 1, to: 100),
    image_url: fig[:image_url],
    user: [user1, user2].sample
  )
end

puts "Created #{Product.count} Star Wars figurines"

# Create orders
3.times do
  order = Order.create!(
    user: [user1, user2].sample,
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
