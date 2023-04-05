class User < ActiveRecord::Base
  has_many :reviews
  has_many :products, through: :reviews

  def favorite_product
    max_review_value = self.reviews.map { |review| review.star_rating }.max
    self.reviews.select { |review| review.star_rating == max_review_value }[
      0
    ].product
  end
end
