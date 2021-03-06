class ReviewsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authorize_user!, only: [:destroy, :edit, :update]
  
  def create
    @product = Product.find params[:product_id]
    @new_review = Review.new review_params
    @new_review.product = @product
    @new_review.user = current_user
    if @new_review.save
      redirect_to product_url(@product.id)
    else
      @reviews = @product.reviews.order(created_at: :desc)
      render "products/show"
    end
  end

  def destroy
    @review = Review.find params[:id]
    if can? :destroy, @review
      @review.destroy
      redirect_to product_url(@review.product)
    else
      head :unauthorized
    end
  end

  def hide
    @review = Review.find params[:id]
    @review.update(is_hidden: !@review.is_hidden?)
    redirect_to product_url(@review.product)
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end

  # def authorize_user!
  #   redirect_to products_path, alert: "you must be signed in" unless can? :crud, @review
  # end
end
