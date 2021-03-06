# frozen_string_literal: true
class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, index: true, null: false
      t.string :username, index: true, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
