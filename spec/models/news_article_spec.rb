require 'rails_helper'

RSpec.describe NewsArticle, type: :model do
  describe "validates" do
    it("requires a title") do
      news_article = NewsArticle.new(title: nil)
      news_article.valid?
      expect(news_article.errors.messages).to(have_key(:title))
    end

    it("requires title to be unique") do
      news_article_1 = NewsArticle.new(
        title: "This is a title",
        description: "This is s description"
        )
      news_article_1.save

      news_article_2 = NewsArticle.new(
        title: "This is a title"
      )
      news_article_2.valid?
      expect(news_article_2.errors.messages).to(have_key(:title))
    end
  end
end
