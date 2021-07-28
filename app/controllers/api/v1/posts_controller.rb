class Api::V1::PostsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  before_action :find_post, only: [:show, :update]

  def index
    @posts = Post.all
  end

  def show
  end

  def update
    if @post.update(user_params)
      render :show
    else
      render_error
    end
  end

  private

  def render_error
    render json: {error: @user.errors.full_message}
  end

  def user_params
      params.require(:post).permit(:mood, :text, :date)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end