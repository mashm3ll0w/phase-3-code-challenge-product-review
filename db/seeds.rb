require 'httparty'
require 'json'
require 'sinatra/activerecord'

require_relative '../app/controllers/application_controller'
require_relative '../app/models/recipe'
require_relative '../app/models/ingredient'
require_relative '../app/models/instruction.rb'
require_relative '../app/models/video'

puts "🌱 Seeding spices..."
puts "Clearing existing seed..."
Recipe.destroy_all

meals = ["chicken", "ham", "bacon", "rice", "beef", "pork"]
meals.each do |meal|
  response = HTTParty.get("https://www.themealdb.com/api/json/v1/1/filter.php?i=#{meal}")
  data = JSON.parse(response.body)
  puts "Seeding #{meal}...."
  puts "API response for #{meal}: #{data.inspect}"

  begin
  meals_data = data["meals"]
  if meals_data.nil?
    puts "No seeds.... Skipping..."
    next
  end

  meals_data.each do |innermeal|
    puts "Inner seeding +++++++++++++++++++++++++++++++++++++#{innermeal}..."
    ingredients = []
    measures = []
    (1..20).each do |n|
      ingredient = innermeal["strIngredient#{n}"]
      measure = innermeal["strMeasure#{n}"]
      break if ingredient.nil? || ingredient.empty? || measure.nil? || measure.empty?
      ingredients << ingredient
      measures << measure
      end
    

    recipe = Recipe.create(
      id: innermeal['idMeal'],
      name: innermeal['strMeal'],
      ingredients: ingredients,
      instructions: innermeal['strInstructions'],
      image_url: innermeal['strMealThumb']
    )
    puts "Recipe of ID #{recipe.id} created"
    end
  rescue StandardError => e
    puts "Error while seeding #{meal}: #{e.message}"
  end
end


puts "✅ Done seeding!"
