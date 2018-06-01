class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string   :guest_name
      t.string   :guest_email
      t.string   :guest_website
      t.text     :body, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at
      t.integer  :author_id
      t.integer  :post_id, null: false
    end

    add_index :comments, :author_id
    add_index :comments, :post_id
    add_index :comments, :created_at, order: { created_at: :desc }, name: :default_ordering_index_on_comments
    add_index :comments, :created_at, order: { id: :asc }, name: :id_ordering_index_on_comments
  end
end
