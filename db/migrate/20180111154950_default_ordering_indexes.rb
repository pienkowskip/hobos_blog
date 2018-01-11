class DefaultOrderingIndexes < ActiveRecord::Migration
  def change
    add_index :assets, :asset_updated_at, order: { asset_updated_at: :desc }, name: :default_ordering_index_on_assets
    add_index :categories, :name, order: { name: :asc }, name: :default_ordering_index_on_categories
    add_index :posts, :created_at, order: { created_at: :desc }, name: :default_ordering_index_on_posts
    add_index :users, :name, order: { name: :asc }, name: :default_ordering_index_on_users
  end
end
