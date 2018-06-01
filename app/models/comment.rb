class Comment < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    guest_name    :string
    guest_email   :string
    guest_website :string
    body    :text, null: false
    timestamps
  end
  attr_accessible :post, :post_id, :guest_name, :guest_email, :author, :author_id, :guest_website, :created_at, :body

  belongs_to :author, class_name: 'User', inverse_of: :comments, creator: true
  belongs_to :post, inverse_of: :comments

  default_scope -> { order(created_at: :desc, id: :desc) }

  validates :post, presence: true
  validates :author, presence: true, if: :author_id

  validates :guest_name, absence: true, if: :author
  validates :guest_email, absence: true, if: :author
  validates :guest_website, absence: true, if: :author

  validates :guest_name, presence: true, unless: :author
  validates :guest_email, presence: true, email: true, unless: :author
  validates :guest_website, url: true, allow_blank: true, unless: :author

  validates :body, presence: true, length: { maximum: 5000 }

  auto_strip_attributes :guest_name, :guest_email, :guest_website, :body

  before_validation do |record|
    unless record.guest_website.blank? || record.guest_website =~ /\A[a-z][a-z0-9.+\-]+:/i
      record.guest_website = 'http://' + record.guest_website
    end
  end

  before_save do |record|
    record.guest_website = URI.parse(record.guest_website).to_s unless record.guest_website.blank?
  end

  def name
    author ? author.name : guest_name
  end

  def email
    author ? author.email_address : guest_email
  end

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
    true
  end

end
