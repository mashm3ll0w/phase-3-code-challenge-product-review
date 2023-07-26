class Recipe < ActiveRecord::Base
    validates :name, presence: true
    validates :instructions, length: { minimum: 20 }
    has_one :instruction
    has_many :videos
    has_and_belongs_to_many :ingredients
end