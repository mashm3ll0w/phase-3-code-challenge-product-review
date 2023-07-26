require 'httparty'
require 'json'

puts "🌱 Seeding spices..."
puts "Clearing existing seed..."
Recipe.destroy_all

meals = ["chicken", "ham", "bacon", "rice", "beef", "pork"]
meals.each do |meal|
  response = HTTParty.get("https://www.themealdb.com/api/json/v1/1/filter.php?i=#{meal}")
  data = JSON.parse(response.body)
  puts "Seeding #{meal}...."
  puts "API response: #{data.inspect}"

  begin
  if data["meals"].nil?
    puts "No seeds.... Skipping..."
    next
  end

  data["meals"].each do |innermeal|
    puts "Inner seeding +++++++++++++++++++++++++++++++++++++#{innermeal}..."
    ingredients = []
    (1..20).each do |i|
      ingredient_name = innermeal["strIngredient#{i}"]
      ingredient_measure = innermeal["strMeasure#{i}"]
      break if ingredient_name.nil? || ingredient_name.strip.empty?
      ingredients << "#{ingredient_measure} #{ingredient_name}"
    end
    

    recipe = Recipe.create(
      id: innermeal['idMeal'],
      name: innermeal['strMeal'],
      ingredients: ingredients,
      instructions: innermeal['strInstructions'],
      str_meal_thumb: innermeal['strMealThumb']
    )
    end
  rescue StandardError => e
    puts "Error while seeding #{meal}: #{e.message}"
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
