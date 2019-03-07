class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
end
