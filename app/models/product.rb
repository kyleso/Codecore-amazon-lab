class Product < ApplicationRecord
  belongs_to(:user)
  has_many(:reviews, dependent: :destroy)

  has_many :favourites, dependent: :destroy
  has_many :favouriters, through: :likes, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates(:title, presence: true, uniqueness: true, case_insensitive: false)
  validates(:price, presence: true, numericality: { greater_than: 0 })
  validates(:description, presence: true, length: { minimum: 10 })

  validate(:capitalize_title)

  before_validation(:set_default_price)
  before_validation(:capitalize_title)

  scope(:search, -> (query) { where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%") })

  def self.search_multiple
    # # where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
    # self.joins(:tags).where(
    #   tags: { name: ["irony", "etsy"] },
    # )
    search_array = query.split(" ").map { |word| "%#{word}%" }
    self.join(:tags).where("tags.name ILIKE ANY (array[?])", search_array)
  end

  def tag_names
    self.tags.map { |t| t.name }.join(", ")
  end

  def tag_names=(rhs)
    self.tags = rhs.strip.split(/\s*,\s*/).map do |tag_name|
      Tag.find_or_initialize_by(name: tag_name)
    end
  end

  private

  def set_default_price
    self.price ||= 1
  end

  def capitalize_title
    self.title.titleize
  end
end
