class AddNotesAndFavoritesToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :notes, :text
    add_column :recipes, :favorites, :boolean, default: false
  end
end
