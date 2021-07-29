class Api::V1::PostsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  before_action :find_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def update
    if @post.update(post_params)
      render :show
    else
      render_error
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render :show, status:  :created
    else
      render_error
    end
  end

  def destroy
    @post.destroy
  end

  private

  def render_error
    render json: {error: @post.errors.full_message}
  end

  def post_params
      params.require(:posts).permit(:mood, :text, :date, :user_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end