# frozen_string_literal: true
class PostSerializer < ActiveModel::Serializer
  attributes :id, :username, :description
end
