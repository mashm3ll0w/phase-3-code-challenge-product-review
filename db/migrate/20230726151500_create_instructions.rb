class CreateInstructions < ActiveRecord::Migration[6.1]
  def change
    create_table :instructions do |t|
      t.references :recipe, foreign_key: true
      t.text :content
      t.timestamps
    end
  end
end
