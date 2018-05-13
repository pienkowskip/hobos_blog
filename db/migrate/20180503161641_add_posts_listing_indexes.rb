class AddPostsListingIndexes < ActiveRecord::Migration
  def change
    add_index :posts, :state
    add_index :posts, :published_at, order: { published_at: :desc }
  end
end
