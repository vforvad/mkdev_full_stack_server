class Api::V1::PostsController < Api::ApiController
  before_action :find_post, only: [:update, :destroy]

  def index
    posts = Post.all
    render json: posts
  end

  def create
    form = Form::Post.new(Post.new, params[:post])
    if form.submit
      render json: form, serializer: PostSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def update
    form = Form::Post.new(@post, params[:post])
    if form.submit
      render json: form, serializer: PostSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
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
end
