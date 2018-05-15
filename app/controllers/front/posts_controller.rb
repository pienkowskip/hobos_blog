module Front
  class PostsController < BaseController
    def collection
      Post.unscoped.published
    end

    def index
      @posts = collection.published_at_order.includes(:author, :picture)
    end

    def show
      @post = collection.find(params[:id])
      redirect_to post_url(@post) unless params[:id] == @post.to_param
      qp = collection.published_at_order_at(@post)
      @prev_post = qp.previous(false)
      @next_post = qp.next(true)
    end
  end
end