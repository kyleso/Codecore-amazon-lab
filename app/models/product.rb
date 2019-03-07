class Product < ApplicationRecord
  belongs_to(:user)
  has_many(:reviews, dependent: :destroy)

  has_many :favourites, dependent: :destroy
  has_many :favouriters, through: :likes, source: :user

  validates(:title, presence: true, uniqueness: true, case_insensitive: false)
  validates(:price, presence: true, numericality: { greater_than: 0 })
  validates(:description, presence: true, length: { minimum: 10 })

  validate(:capitalize_title)

  before_validation(:set_default_price)
  before_validation(:capitalize_title)

  scope(:search, -> (query) { where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%") })

  private

  def set_default_price
    self.price ||= 1
  end

  def capitalize_title
    self.title.titleize
  end
end
