# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::PostsController do
  let!(:post) { create :post }

  describe 'GET #index' do
    it 'loads posts list' do
      get :index
      expect(JSON.parse(response.body)).to have_key('posts')
    end

    context 'response' do
      before { get :index }

      %w(id title body username).each do |attr|
        it "success response contains #{attr}" do
          expect(response.body).to be_json_eql(post.send(attr.to_sym).to_json)
            .at_path("posts/0/#{attr}")
        end
      end
    end
  end

  describe 'POST #create' do

  end

  describe 'PUT #update' do

  end

  describe 'DELETE #destroy' do

  end
end
