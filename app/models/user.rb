class User < ApplicationRecord
  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :news_articles, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

  has_many :favourites, dependent: :destroy
  has_many :favourited_products, through: :favourites, source: :product

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  after_save(:capitalize_name)

  def full_name
    "#{first_name} #{last_name}".strip
  end

  private

  def capitalize_name
    self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
  end
end
