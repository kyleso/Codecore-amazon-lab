class NewsArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]

  def new
    @news_article = NewsArticle.new
  end

  def create
    @news_article = NewsArticle.new news_article_params
    @news_article.user = current_user
    if @news_article.save
      redirect_to news_article_url(@news_article)
    else
      render :new
    end
  end

  def show
    @news_article = NewsArticle.find(params[:id])
  end

  def destroy
    news_article = NewsArticle.find(params[:id])
    if can?(:destroy, news_article)
      news_article.destroy
      redirect_to news_articles_url
    else
      flash[:danger] = "Access Denied"
      redirect_to news_article_url(news_article.id)
    end
  end

  def edit
    @news_article = NewsArticle.find(params[:id])
    if can?(:edit, @news_article)
      render :edit
    else
      flash[:danger] = "Access Denied"
      redirect_to root_path
    end
  end

  def update
    @news_article = NewsArticle.find(params[:id])
    if can?(:update, @news_article)
      if @news_article.update news_article_params
        redirect_to news_article_path(@news_article.id)
      else
        render :edit
      end
    else
      flash[:danger] = "Access Denied"
      redirect_to root_path
    end
  end

  private

  def news_article_params
    params.require(:news_article).permit(:title, :description)
  end
end
