class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params) # Automatically set user_id

    if @post.save
      flash[:success] = "Post succesfully created"
      redirect_to :root
    else
      flash.now[:error] = "Something is wrong"
      render :new, status: :unprocessable_entity
    end
  end

  private

  # def require_login
  #   unless logged_in?
  #     flash[:error] = "You must be logged in to access"
  #     redirect_to new_login_url
  #   end
  # end

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
