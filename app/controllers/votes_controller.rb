class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    vote = Vote.new(user: current_user, review: review, is_up: params[:is_up])
    if !can?(:vote, review)
      flash[:warning] = "You can't vote on your own review"
    elsif vote.save
      flash[:success] = "Vote added to review"
    else
      flash[:danger] = vote.errors.full_messages.join(", ")
    end
    redirect_to product_path(vote.review.product)
  end

  def update
    vote = current_user.votes.find params[:id]
    if can?(:update, vote)
      vote.update is_up: params[:is_up]
      flash[:success] = "Vote Changed"
    else
      flash[:warning] = "You can't change this vote"
    end
    redirect_to product_path(vote.review.product)
  end

  def destroy
    vote = current_user.votes.find params[:id]
    if can?(:destroy, vote)
      vote.destroy
      flash[:success] = "Vote removed"
    else
      flash[:warning] = "Can't remove vote"
    end
    redirect_to product_path(vote.review.product)
  end
end
