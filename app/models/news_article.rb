class NewsArticle < ApplicationRecord
  belongs_to(:user)

  validates(:title, presence: true, uniqueness: true)
  validates(:description, presence: true)

  validate(:published_later_than_created)

  after_save(:capitalize_title)

  def publish
    self.published_at = DateTime.now
  end

  private

  def published_later_than_created
    return if published_at.blank?

    if published_at < created_at
      errors.add(:published_at, "Must be after date created")
    end
  end

  def capitalize_title
    self.title = self.title.titleize
  end
end
