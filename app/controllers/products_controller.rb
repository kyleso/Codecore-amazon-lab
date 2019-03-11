class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:destroy, :edit, :update]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    @product.user = current_user
    if @product.save
      ProductMailer.notify_product_creator(@product).deliver_now
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  def show
    @new_review = Review.new
    @avg = average_rating
    if @product.user == current_user
      @reviews = @product.reviews.order(created_at: :desc)
    else
      @reviews = @product.reviews.where("is_hidden = false").order(created_at: :desc)
    end
    @favourite = @product.favourites.find_by(user: current_user)
  end

  def index
    if params[:tag]
      @tag = Tag.find_or_initialize_by(name: params[:tag])
      @products = @tag.products.order(created_at: :desc)
    else
      @products = Product.all.order(created_at: :desc)
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  def edit
  end

  def update
    if @product.update product_params
      redirect_to product_path(@product.id)
    else
      render :edit
    end
  end

  def favourited
    @products = current_user.favourited_products.order(created_at: :desc)
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :tag_names)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def authorize_user!
    redirect_to products_path, alert: "you must be signed in" unless can? :crud, @product
  end

  def average_rating
    @product.reviews.average(:rating)
  end
end
