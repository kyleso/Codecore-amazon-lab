class Product < ApplicationRecord

  has_many(:reviews, dependent: :destroy)

  validates(:title, presence: true, uniqueness: true, case_insensitive: false)
  validates(:price, presence: true, numericality: { greater_than: 0 })
  validates(:description, presence: true, length: { minimum: 10 })

  validate(:capitalize_title)

  before_validation(:set_default_price)
  before_validation(:capitalize_title)

  scope(:search, ->(query) { where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%") })

  private

  def set_default_price
    self.price ||= 1
  end

  def capitalize_title
    self.title.titleize
  end

end
