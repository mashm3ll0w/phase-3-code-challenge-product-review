class CreateFavouritesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :favourites do |t|
      t.references :recipes, foreign_key: true
    end
  end
end
