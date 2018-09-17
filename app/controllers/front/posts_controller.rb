module Front
  class PostsController < BaseController
    include HoboPermissionsHelper

    def collection
      Post.unscoped.published
    end

    def index
      @posts = collection.published_at_order.includes(:author, :picture)
    end

    def show
      @post = collection.find(params[:id])
      unless params[:id] == @post.to_param
        redirect_to post_url(@post)
        return
      end
      load_show_records
      @comment = Comment.new
    end

    def preview
      raise AbstractController::ActionNotFound unless logged_in?
      @post = Post.unscoped.find(params[:id])
      unless @post.state == 'published' || current_user.administrator? || @post.author == current_user
        raise ActionController::Forbidden
      end
      redirect_to preview_post_url(@post) unless params[:id] == @post.to_param
    end

    def comment
      @post = collection.find(params[:id])
      @comment = Comment.new(params.require(:comment).permit(:guest_name, :guest_email, :guest_website, :body))
      @comment.post = @post
      @comment.author = current_user if logged_in?
      if @comment.save
        redirect_to post_url(@post, anchor: "comment-#{@comment.id}")
      else
        load_show_records
        render :show
      end
    end

    def search
      @search_query = params[:query].strip
      @posts = collection.includes(:author).search_by_content(@search_query).with_pg_search_highlight
    end

    private

    def load_show_records
      @post.comments.includes(:author).load
      qp = collection.published_at_order_at(@post)
      @prev_post = qp.previous(false)
      @next_post = qp.next(true)
    end
  end
end