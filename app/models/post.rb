class Post < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title        :string, :required, null: false
    state        :string, :required, null: false, default: 'draft'
    published_at :datetime
    body         :text, :required, null: false
    excerpt      :text
    timestamps
  end
  attr_accessible :title, :published_at, :author, :author_id, :category, :category_id, :body, :excerpt, :state

  belongs_to :author, class_name: 'User', inverse_of: :posts
  belongs_to :category, inverse_of: :posts

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    acting_user.signed_up?
  end

  def destroy_permitted?
    acting_user.signed_up?
  end

  def view_permitted?(field)
    acting_user.signed_up?
  end

end
