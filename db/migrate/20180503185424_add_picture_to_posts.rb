class AddPictureToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :picture_id, :integer
    add_index :posts, [:picture_id]
  end
end
