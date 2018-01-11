class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string   :title, :null => false
      t.string   :state, :null => false, :default => "draft"
      t.datetime :published_at
      t.text     :body, :null => false
      t.text     :excerpt
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :author_id
    end
    add_index :posts, [:author_id]
  end
end
