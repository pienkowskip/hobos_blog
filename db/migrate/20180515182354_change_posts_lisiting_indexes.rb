class ChangePostsLisitingIndexes < ActiveRecord::Migration
  def change
    remove_index :posts, :published_at # Remove old ordering index.
    add_index :posts, :published_at
    add_index :posts, :published_at, order: {published_at: :desc}, name: :published_at_order_desc
    add_index :posts, :id, order: {id: :desc}, name: :id_order_desc
  end
end
