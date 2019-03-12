class ProductSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :description,
    :price,
    :rating,
    :created_at,
    :updated_at
  )

  belongs_to :user, key: :seller
  has_many :reviews

  class ReviewSerializer < ActiveModel::Serializer
    attributes(
      :id,
      :body,
      :rating
    )

    belongs_to :user, key: :author
  end
end
