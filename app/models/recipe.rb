class Recipe < ActiveRecord::Base
    validates :name, presence: true
    has_many :instructions
    has_many :videos
    has_many :favourites
    has_and_belongs_to_many :ingredients
end
