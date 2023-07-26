require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'json'
require 'httparty'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/recipes" do 
  ingredient = params[:ingredients]
  response = HTTParty.get("https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}")
  data = JSON.parse(response.body)
  
  # Process the API data and save it to your database
  if data && data['meals'].is_a?(Array)
    data['meals'].map do |meal|
      recipe = Recipe.find_or_create_by(id: meal['idMeal'])
      recipe.update(
        name: meal['strMeal'],
        str_meal_thumb: meal['strMealThumb'],
      )
    
      instruction = Instruction.find_or_create_by(recipe_id: recipe.id_meal)
      instruction.update(content: meal['strInstructions'])
    
      ingredients = []
      (1..20).each do |i|
        ingredient_name = meal["strIngredient#{i}"]
        ingredient_measure = meal["strMeasure#{i}"]
        break if ingredient_name.nil? || ingredient_name.strip.empty?
        ingredient = Ingredient.find_or_create_by(name: ingredient_name)
        ingredients << "#{ingredient_measure} #{ingredient_name}" if ingredient
      end
        
      recipe.update(ingredients: ingredients)
    end

    recipes = Recipe.all
    recipes.to_json
  else
    { message: 'Data fetched and saved to the database.' }.to_json
  end
end


  get "/recipes/:id" do 
    recipe = Recipe.find_by(id: params[:id])

    if recipe
      {
        id: recipe.id_meal,
        name: recipe.name,
        ingredients: recipe.ingredients,
        instructions: recipe.instructions,
        str_meal_thumb: recipe.str_meal_thumb
      }.to_json
    else
      status 404
      { error: 'Recipe not found' }.to_json
    end
  end

  get "/recipes/:id/video" do 
    recipe = Recipe.find_by(id_meal: params[:id])

    if recipe
      videos = Video.where(recipe_id: params[:id])
      videos.to_json
    else
      status 404
      { error: 'Recipe not found' }.to_json
    end
  end

  not_found do 
    status 404
    { error: "Not found" }.to_json
  end
end