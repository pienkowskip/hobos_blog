class Caption < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    textid           :string, :required, null: false, name: true
    body             :text
    timestamps
  end
  attr_accessible :body

  default_scope -> { order(:textid) }

  # --- Permissions --- #

  def create_permitted?
    false
  end

  def update_permitted?
    acting_user.signed_up?
  end

  def destroy_permitted?
    false
  end

  def view_permitted?(field)
    acting_user.signed_up?
  end
end
