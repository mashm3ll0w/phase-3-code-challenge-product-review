# This will delete any existing rows from the Product and User tables
# so you can run the seed file multiple times without having duplicate entries in your database
puts "Deleting old data..."
Product.destroy_all
User.destroy_all

puts "Creating users..."
user1 = User.create(name: Faker::Name.name)
user2 = User.create(name: Faker::Name.name)
user3 = User.create(name: Faker::Name.name)

puts "Creating products..."
product1 = Product.create(name: "Stapler", price: 10)
product2 = Product.create(name: "Whiteboard", price: 15)
product3 = Product.create(name: "Dry Erase Markers", price: 5)
product4 = Product.create(name: "Ballpoint Pens", price: 2)
product5 = Product.create(name: "Scotch Tape", price: 3)

puts "Creating reviews..."
# *****************************************************************
# * TODO: create reviews! Remember, a review belongs to a product *
# * and a review belongs to an user.                              *
# *****************************************************************
# Create Reviews Here
review1 =
  Review.create(
    star_rating: 5,
    comment: "Good",
    user_id: user1.id,
    product_id: product1.id
  )
review2 =
  Review.create(
    star_rating: 4,
    comment: "Better",
    user_id: user2.id,
    product_id: product2.id
  )
review3 =
  Review.create(
    star_rating: 3,
    comment: "Suck",
    user_id: user3.id,
    product_id: product3.id
  )
review4 =
  Review.create(
    star_rating: 2,
    comment: "Meh",
    user_id: user1.id,
    product_id: product4.id
  )
review5 =
  Review.create(
    star_rating: 1,
    comment: "Uhh",
    user_id: user2.id,
    product_id: product5.id
  )
review6 =
  Review.create(
    star_rating: 5,
    comment: "Excellent",
    user_id: user3.id,
    product_id: product1.id
  )
review7 =
  Review.create(
    star_rating: 4,
    comment: "Brr",
    user_id: user1.id,
    product_id: product2.id
  )
review8 =
  Review.create(
    star_rating: 3,
    comment: "Like it",
    user_id: user2.id,
    product_id: product3.id
  )
review9 =
  Review.create(
    star_rating: 2,
    comment: "Flat",
    user_id: user3.id,
    product_id: product4.id
  )
review10 =
  Review.create(
    star_rating: 1,
    comment: "What was I thinkinh",
    user_id: user1.id,
    product_id: product5.id
  )
puts "Seeding done!"
