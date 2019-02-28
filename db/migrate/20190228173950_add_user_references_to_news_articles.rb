class AddUserReferencesToNewsArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :news_articles, :user, foreign_key: true
  end
end
