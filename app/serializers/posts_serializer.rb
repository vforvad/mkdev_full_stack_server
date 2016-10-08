class PostsSerializer < ActiveModel::Serializer
  attributes :id, :username, :description
end
