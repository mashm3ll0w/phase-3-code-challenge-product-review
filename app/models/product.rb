class Product < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  def leave_review(user, star_rating, comment)
    if user.is_a?(User) && star_rating.is_a?(Integer) && comment.is_a?(String)
      Review.create(
        star_rating: star_rating,
        comment: comment,
        user_id: user.id,
        product_id: self.id
      )
    else
      "Please check the data types of your user/star_rating and/or comment"
    end
  end

  def print_all_reviews
    self
      .reviews
      .map do |review|
        puts "Review for #{self.name} by #{review.user.name}: #{review.star_rating}. #{review.comment}"
      end
      .compact
  end
end
