class AddIdMealAndThumbToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :id_meal, :string
    add_column :recipes, :str_meal_thumb, :string
  end
end
