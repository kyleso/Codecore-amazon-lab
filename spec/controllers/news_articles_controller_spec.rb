require "rails_helper"

RSpec.describe NewsArticlesController, type: :controller do
  describe "#new" do
    it "renders a new template" do
      get(:new)
      expect(response).to(render_template(:new))
    end

    it "sets an instance variable with a new news article" do
      get(:new)
      expect(assigns(:news_article)).to(be_a_new(NewsArticle))
    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        post(:create, params: { news_article: FactoryBot.attributes_for(:news_article) })
      end

      it "creates new news article in database" do
        count_before = NewsArticle.count
        valid_request
        count_after = NewsArticle.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the show page of that news article" do
        valid_request
        news_article = NewsArticle.last
        expect(response).to(redirect_to(news_article_url(news_article.id)))
      end
    end

    context "with invalid paramters" do
      def invalid_request
        post(:create, params: { news_article: FactoryBot.attributes_for(:news_article, title: nil) })
      end

      it "doesn't create a news article in the database" do
        count_before = NewsArticle.count
        invalid_request
        count_after = NewsArticle.count
        expect(count_after).to eq(count_before)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to(render_template(:new))
      end

      it "assigns an invalid news article as an instance variable" do
        invalid_request
        expect(assigns(:news_article)).to be_a(NewsArticle)
        expect(assigns(:news_article).valid?).to be(false)
      end
    end
  end

  describe "#show" do
    it "renders the show template" do
      news_article = FactoryBot.create(:news_article)
      get(:show, params: { id: news_article.id })
      expect(response).to(render_template(:show))
    end

    it "sets @news_article for the shown object" do
      news_article = FactoryBot.create(:news_article)
      get(:show, params: { id: news_article.id })
      expect(assigns(:news_article)).to eq(news_article)
    end
  end

  describe "#destroy" do
    it "removes a news article from the database" do
      news_article = FactoryBot.create(:news_article)
      delete(:destroy, params: { id: news_article.id })
      expect(NewsArticle.find_by(id: news_article.id)).to be(nil)
    end

    it "redirects to the news article index" do
      news_article = FactoryBot.create(:news_article)
      delete(:destroy, params: { id: news_article.id })
      expect(response).to redirect_to(news_articles_url)
    end
  end

  describe "#edit" do
    it "renders an edit template" do
      news_article = FactoryBot.create(:news_article)
      get(:edit, params: { id: news_article.id })
      expect(response).to(render_template(:edit))
    end
    it "sets an instance variable for the article being edited" do
      news_article = FactoryBot.create(:news_article)
      get(:edit, params: { id: news_article.id })
      expect(assigns(:news_article)).to eq(news_article)
    end
  end

  describe "#update" do
    before do
      @news_article = FactoryBot.create(:news_article)
    end

    context "with valid parameters" do
      it "updates news article in db" do
        new_title = "#{@news_article.title} and some other stuff"
        patch(:update, params: {
                         id: @news_article.id,
                         news_article: {
                           title: new_title,
                         },
                       })
        expect(@news_article.reload.title).to eq(new_title)
      end

      it "redirects to the news_article show page" do
        new_title = "#{@news_article.title} and some other stuff"
        patch(:update, params: {
                         id: @news_article.id,
                         news_article: {
                           title: new_title,
                         },
                       })
        expect(response).to (redirect_to(@news_article))
      end
    end
    context "with invalid parameters" do
      def invalid_request
        patch :update, params: { id: @news_article.id, news_article: { title: nil } }
      end

      it "doesn't update the database with invalid params" do
        invalid_request
        expect { invalid_request }.to_not change { @news_article.reload.title }
      end

      it "renders edit template again" do
        invalid_request
        expect(response).to (render_template(:edit))
      end
    end
  end
end
