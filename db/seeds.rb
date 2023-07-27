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
Instruction.destroy_all
Ingredient.destroy_all
Recipe.destroy_all


#Recipe seed data
recipes = [
  {
    name: "BBQ Pork Sloppy Joes",
    str_meal_thumb: "https://www.themealdb.com/images/media/meals/atd5sh1583188467.jpg",
    id_meal: "52995",
    notes: "Delicious BBQ flavored pork sloppy joes.",
    favorites: true
  },
  {
    name: "Bigos (Hunters Stew)",
    str_meal_thumb: "https://www.themealdb.com/images/media/meals/md8w601593348504.jpg",
    id_meal: "53018",
    notes: "A traditional Polish hunters stew with pork.",
    favorites: false
  },
  {
    name: "Hot and Sour Soup",
    str_meal_thumb: "https://www.themealdb.com/images/media/meals/1529445893.jpg",
    id_meal: "52954",
    notes: "Spicy and sour soup with pork and vegetables.",
    favorites: true
  },
  {
    name: "Japanese Katsudon",
    str_meal_thumb: "https://www.themealdb.com/images/media/meals/d8f6qx1604182128.jpg",
    id_meal: "53034",
    notes: "Japanese rice bowl with breaded pork cutlets and egg.",
    favorites: false
  },
  {
    name: "Pork Cassoulet",
    str_meal_thumb: "https://www.themealdb.com/images/media/meals/wxuvuv1511299147.jpg",
    id_meal: "52847",
    notes: "A rich and hearty French casserole with pork and beans.",
    favorites: true
  }
]

#Instructions seed data
Recipe.transaction do
  recipes.each do |recipe_data|
    recipe = Recipe.create!(recipe_data)

    case recipe.id_meal
    when "52995"
      recipe.instructions.create(content: "In a skillet, cook ground pork with BBQ sauce. Serve on hamburger buns with coleslaw.")
      recipe.ingredients.create(name: "Ground Pork", quantity: "500g")
      recipe.ingredients.create(name: "BBQ Sauce", quantity: "1 cup")
      recipe.ingredients.create(name: "Hamburger Buns", quantity: "4")
      recipe.ingredients.create(name: "Coleslaw", quantity: "1 cup")
    when "53018"
      recipe.instructions.create(content: "Cook pork with sauerkraut and vegetables. Simmer until flavors blend.")
      recipe.instructions.create(content: "Simmer pork with onions.") # Adjust the instruction content to meet the validation requirement.
      recipe.ingredients.create(name: "Pork Shoulder", quantity: "1 kg")
      recipe.ingredients.create(name: "Sauerkraut", quantity: "500g")
      recipe.ingredients.create(name: "Onion", quantity: "1")
      recipe.ingredients.create(name: "Carrots", quantity: "2")
      recipe.ingredients.create(name: "Tomato Paste", quantity: "2 tbsp")
    end
  end
end


puts "✅ Done seeding!"
