class Category < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string, :required, :unique, null: false
  end
  attr_accessible :name

  has_many :posts, dependent: :restrict_with_exception, inverse_of: :category
  children :posts

  default_scope -> { order(name: :asc) }

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
