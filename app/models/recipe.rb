class Recipe < ActiveRecord::Base
    validates :name, presence: true
    validates :ingredients, length: { minimum: 10 }
    validates :instructions, length: { minimum: 20 }
    has_many :videos
end