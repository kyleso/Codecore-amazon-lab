class ReviewSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :body,
    :rating,
    :reviewer
  )

  belongs_to :user, key: :reviewer
  # has_one :user

  # def author
  #   # ActiveModelSerializers::SerializableResource.new(object.user, each_serializer: UserSerializer)
  #   object.user.first_name
  #   UserSerializer.new object.user
  # end
end
