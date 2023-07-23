puts "🌱 Seeding spices..."

# Seed your database here
Recipe.create(
    name: "Matar Paneer",
    ingredients: "Matar, Paneer, Spices, Tomato, Onion",
    instructions: "1. Heat oil in a pan..."
  )
  
  Video.create(
    title: "Matar Paneer Recipe",
    url: "https://www.youtube.com/watch?v=your-video-url",
    description: "Learn how to make delicious Matar Paneer...",
    recipe_id: 1 # The ID of the associated recipe
  )
puts "✅ Done seeding!"
