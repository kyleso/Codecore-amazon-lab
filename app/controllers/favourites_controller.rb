class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    favourite = Favourite.new(user: current_user, product: product)
    if favourite.save
      flash[:success] = "Product added to favourites"
    else
      flash[:danger] = favourite.errors.full_messages.join(", ")
    end
    redirect_to product_path(product)
  end

  def destroy
    favourite = current_user.favourites.find params[:id]
    if can?(:destroy, favourite)
      favourite.destroy
      flash[:success] = "Product removed from favourites"
    else
      flash[:warning] = "Can't remove product from favourites"
    end
    redirect_to product_path(favourite.product)
  end
end
