class Video < ActiveRecord::Base
    validates :title, presence: true
    validates :url, presence: true
    validates :description, length: { minimum: 10 }
    belongs_to :recipe
end