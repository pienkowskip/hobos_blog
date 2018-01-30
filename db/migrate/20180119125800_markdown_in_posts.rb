class MarkdownInPosts < ActiveRecord::Migration
  def change
    add_column :posts, :markdown_body, :text, null: false
    add_column :posts, :markdown_excerpt, :text
  end
end
