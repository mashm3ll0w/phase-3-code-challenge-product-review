class Recipe < ActiveRecord::Base
    validates :name, presence: true
    validates :instructions, length: { minimum: 20 }
    has_many :instructions
    has_many :videos
    has_and_belongs_to_many :ingredients
end