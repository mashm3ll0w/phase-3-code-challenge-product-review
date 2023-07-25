require 'httparty'
require 'json'

puts "🌱 Seeding spices..."
puts "Clearing existing seed..."
# Recipe.destroy_all

meals = ["chicken", "ham", "bacon", "rice", "beef", "pork"]
meals.each do |meal|
  response = HTTParty.get("https://www.themealdb.com/api/json/v1/1/filter.php?i=#{meal}")
  data = JSON.parse(response.body)
  puts "Seeding #{data}"
  data["meals"].each do |innermeal|
    puts "Inner seeding +++++++++++++++++++++++++++++++++++++#{innermeal}..."
    Recipe.create(
    name: innermeal['strMeal'],
    ingredients: meal,
    instructions: innermeal['strInstructions'],
    str_meal_thumb: innermeal['strMealThumb']
  )
  end
end


# def extract_ingredients(meal)
#   ingredients = []
#   (1..20).each do |i|
#     ingredient = meal["strIngredient#{i}"]
#     measure = meal["strMeasure#{i}"]
#     break if ingredient.nil? || ingredient.strip.empty?
#     ingredients << "#{measure} #{ingredient}"
#   end
#   ingredients.join(',')
# end


# puts "Fetching ingredients..."
# ingredient = 'chickenbreast'
# response = HTTParty.get("https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}")
# data = JSON.parse(response.body)

#   # Process the API data and save it to your database
#   puts "Saving results..."
#   data['meals'].each do |meal|
#   recipe = Recipe.find_or_initialize_by(id_meal: meal['idMeal'])
#   recipe.assign_attributes(
#     name: meal['strMeal'],
#     ingredients: extract_ingredients(meal),
#     instructions: meal['strInstructions'],
#     str_meal_thumb: meal['strMealThumb']
#   )
#   recipe.save
#     recipe
#   end

puts "✅ Done seeding!"



# Seed your database here
# Recipe.create(
#     name: "Matar Paneer",
#     ingredients: "Matar, Paneer, Spices, Tomato, Onion",
#     instructions: "1. Heat oil in a pan..."
#   )
  
#   Video.create(
#     title: "Matar Paneer Recipe",
#     url: "https://www.youtube.com/watch?v=your-video-url",
#     description: "Learn how to make delicious Matar Paneer...",
#     recipe_id: 1 # The ID of the associated recipe
#   )
