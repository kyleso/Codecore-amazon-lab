class ReviewsController < ApplicationController
  def create
    @product = Product.find params[:product_id]
    @new_review = Review.new review_params
    @new_review.product = @product

    if @new_review.save
      redirect_to product_url(@product.id)
    else
      @reviews = @product.reviews.order(created_at: :desc)
      render "products/show"
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_url(@review.question)
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
