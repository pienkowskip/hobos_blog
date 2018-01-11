class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name, :null => false
    end

    change_column :users, :administrator, :boolean, :default => false

    add_column :posts, :category_id, :integer

    add_index :posts, [:category_id]
  end

  def self.down
    change_column :users, :administrator, :boolean, default: false

    remove_column :posts, :category_id

    drop_table :categories

    remove_index :posts, :name => :index_posts_on_category_id rescue ActiveRecord::StatementInvalid
  end
end
