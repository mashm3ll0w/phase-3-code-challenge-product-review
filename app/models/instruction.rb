class Instruction < ActiveRecord::Base
    belongs_to :recipe, foreign_key: 'recipe_id'
end