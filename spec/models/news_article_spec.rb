require 'rails_helper'

RSpec.describe NewsArticle, type: :model do
  describe "validates" do
    it("requires a title") do
      news_article = NewsArticle.new(title: nil)
      news_article.valid?
      expect(news_article.errors.messages).to(have_key(:title))
    end

    it("requires title to be unique") do
      news_article_1 = NewsArticle.create(
        title: "This is a title",
        description: "This is s description"
        )

      news_article_2 = NewsArticle.new(
        title: "This is a title"
      )
      news_article_2.valid?
      expect(news_article_2.errors.messages).to(have_key(:title))
    end

    it("requires a description") do
      news_article = NewsArticle.new(description: nil)
      news_article.valid?
      expect(news_article.errors.messages).to(have_key(:description))
    end

    it("requires published_date to be later than created_at") do
      news_article = NewsArticle.new(
        title: "This is the title",
        description: "this is a description",
        created_at: DateTime.now,
        published_at: DateTime.new(2001,2,3,4,5,6)
        )
      news_article.valid?
      expect(news_article.errors.messages).to(have_key(:published_at))
    end

    it("requires title to be titleized after saving to database") do
      news_article = NewsArticle.create(
        title: "i am the title",
        description: "I am the description",
      )
      expect(news_article.title).to(eq("I Am The Title"))
    end
  end

  describe "#publish" do
    it("sets published_at to current date") do
      news_article = NewsArticle.create(
        title: "I'm a valid title",
        description: "I'm a valid description",
      )
      news_article.publish
      expect(news_article.published_at.to_i).to(eq(DateTime.now.to_i))
    end
  end
end
