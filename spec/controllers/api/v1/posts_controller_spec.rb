# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::PostsController do
  let!(:post_info) { create :post }

  def post_params
    {
      title: 'Title',
      body: 'Body',
      username: 'UserName'
    }
  end

  describe 'GET #index' do
    it 'loads posts list' do
      get :index
      expect(JSON.parse(response.body)).to have_key('posts')
    end

    context 'response' do
      before { get :index }

      %w(id title body username).each do |attr|
        it "success response contains #{attr}" do
          expect(response.body).to be_json_eql(post_info.send(attr.to_sym).to_json)
            .at_path("posts/0/#{attr}")
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates new post' do
        expect do
          post :create, params: { post: post_params }
        end.to change(Post, :count).by(1)
      end

      context 'success response' do
        before { post :create, params: { post: post_params } }

        %w(id title body username).each do |attr|
          it "success response contains #{attr}" do
            expect(response.body).to be_json_eql(Post.last.send(attr.to_sym).to_json)
              .at_path("post/#{attr}")
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create new post' do
        expect do
          post :create, params: { post: { title: '' } }
        end.to change(Post, :count).by(0)
      end

      context 'errors' do
        before { post :create, params: { post: { title: '' } } }

        %w(title body username).each do |attr|
          it "failed response contains #{attr} error" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'update new post' do
        put :update, params: { id: post_info.id, post: { title: '1' } }
        post_info.reload
        expect(post_info.title).to eq('1')
      end

      context 'success response' do
        before do
          put :update, params: { id: post_info.id, post: { title: '1' } }
          post_info.reload
        end

        %w(id title body username).each do |attr|
          it "success response contains #{attr}" do
            expect(response.body).to be_json_eql(post_info.send(attr.to_sym).to_json)
              .at_path("post/#{attr}")
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t update post' do
        put :update, params: { id: post_info.id, post: { title: '' } }
        post_info.reload
        expect(post_info.title).to eq(post_info.title)
      end

      context 'errors' do
        before { put :update, params: { id: post_info.id, post: { title: '' } } }

        %w(title).each do |attr|
          it "failed response contains #{attr} error" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'delete the post' do
      expect do
        delete :destroy, params: { id: post_info.id }
      end.to change(Post, :count).by(-1)
    end
  end
end
