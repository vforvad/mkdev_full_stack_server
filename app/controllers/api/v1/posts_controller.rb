# frozen_string_literal: true
class Api::V1::PostsController < Api::ApiController
  before_action :find_post, only: [:update, :destroy]

  def index
    posts = Post.all
    render json: posts
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, serializer: PostSerializer
    else
      render json: { errors: post.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post, serializer: PostSerializer
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: @post, serializer: PostSerializer
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :username, :body)
  end
end
