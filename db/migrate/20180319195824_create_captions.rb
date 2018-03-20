class CreateCaptions < ActiveRecord::Migration
  def change
    create_table :captions do |t|
      t.string   :textid, :null => false
      t.text     :body
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :captions, [:textid]
  end
end

