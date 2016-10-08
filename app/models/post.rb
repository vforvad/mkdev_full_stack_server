# frozen_string_literal: true
class Post < ApplicationRecord
  validates :title, :username, :body, presence: true
end
