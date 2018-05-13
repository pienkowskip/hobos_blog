module Front
  class PostsController < BaseController
    def index
      @posts = Post.includes(:author, :picture).published.reorder(published_at: :desc)
    end

    def show
      @post = Post.find(params[:id])
      redirect_to post_url(@post) unless params[:id] == @post.to_param
    end
  end
end