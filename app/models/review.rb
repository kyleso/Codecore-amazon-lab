class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
end
