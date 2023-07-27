class AddIdmealAndMeasurementsToIngredients < ActiveRecord::Migration[6.1]
  def change
    add_column :ingredients, :meal_id, :integer
    add_column :ingredients, :measurement, :string
  end
end
