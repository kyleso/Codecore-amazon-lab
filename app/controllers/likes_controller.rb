class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    like = Like.new(user: current_user, review: review)
    if !can?(:like, review)
      flash[:warning] = "You can't like your own review"
    elsif like.save
      flash[:success] = "Review liked"
    else
      flash[:danger] = like.errors.full_messages.join(", ")
    end
    redirect_to product_path(like.review.product)
  end

  def destroy
    like = current_user.likes.find params[:id]
    if can?(:destroy, like)
      like.destroy
      flash[:success] = "Review unliked"
    else
      flash[:warning] = "Can't unlike"
    end
    redirect_to product_path(like.review.product)
  end
end
