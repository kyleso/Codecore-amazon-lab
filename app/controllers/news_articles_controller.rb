class NewsArticlesController < ApplicationController
  def new
    @news_article = NewsArticle.new
  end

  def create
    @news_article = NewsArticle.new news_article_params
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
    @news_article = NewsArticle.find(params[:id])
    @news_article.destroy
    redirect_to news_articles_url
  end

  def edit
    @news_article = NewsArticle.find(params[:id])
  end

  def update
    @news_article = NewsArticle.find(params[:id])
    if @news_article.update news_article_params
      redirect_to news_article_path(@news_article.id)
    else
      render :edit
    end
  end

  private

  def news_article_params
    params.require(:news_article).permit(:title, :description)
  end
end
