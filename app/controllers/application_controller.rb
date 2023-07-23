require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'json'
require 'httparty'


class ApplicationController < Sinatra::Base
set :database, { adapter: 'sqlite3', database: 'db/development.db'}
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
    data['meals'].each do |meal|
      Recipe.create(
        name: meal['strMeal'],
        ingredients: meal['strIngredients1'],
        instructions: meal['strInstructions'])
    end
  
    { message: 'Data fetched and saved to the database.' }.to_json
  end

  get "/recipes/:id" do 
  recipe = Recipe.find_by(id: params[:id])

  if recipe
    recipe.to_json
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