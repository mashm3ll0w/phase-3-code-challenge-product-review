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
    ingredient = params[:ingredient]
    response = HTTParty.get("https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}")
    data = JSON.parse(response.body)
  
    # Process the API data and save it to your database
    ingredients = data['meals'].map do |meal|
      recipe = Recipe.find_or_initialize_by(id_meal: meal['idMeal'])
      recipe.assign_attributes(
        name: meal['strMeal'],
        ingredients: extract_ingredients(meal),
        instructions: meal['strInstructions'],
        str_meal_thumb: meal['strMealthumb'],
      )
      recipe.save
      recipe
    end

    { message: 'Data fetched and saved to the database.', 
      ingredients: ingredients}.to_json
  end


  # Gibberish trial to get data to the db
  def extract_ingredients(meal)
    ingredients = []
    (1..20).each do |i|
      ingredient = meal["strIngredient#{i}"]
      measure = meal["strMeasure#{i}"]
      break if ingredient.nil? || ingredient.strip.empty?
      ingredients << "#{measure} #{ingredient}"
    end
    ingredients.join(', ')
  end

  get "/recipes/:id" do 
  recipe = Recipe.find_by(id: params[:id])

  if recipe
    {
      id_meal: recipe.id_meal,
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
    recipe = Recipe.find_by(id: params[:id])

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