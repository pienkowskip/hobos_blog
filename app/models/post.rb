class Post < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title :string, :required, null: false
    state :string, :required, null: false, default: 'draft'
    published_at :datetime
    body :text, null: false
    excerpt :text
    markdown_body :text, :required, null: false
    markdown_excerpt :text
    timestamps
  end
  attr_accessible :title, :published_at, :author, :author_id, :category, :category_id, :picture, :picture_id, :body, :markdown_body, :excerpt, :markdown_excerpt, :state

  include OrderQuery
  include PgSearch

  belongs_to :author, class_name: 'User', inverse_of: :posts, creator: true
  belongs_to :picture, class_name: 'Asset', inverse_of: :posts
  belongs_to :category, inverse_of: :posts
  has_many :comments, -> { reorder(:created_at, :id) }, inverse_of: :post

  validate :validate_markdown_fields

  before_save :update_html_from_markdown

  order_query :published_at_order, [:published_at, :desc], [:id, :desc]
  default_scope -> { order(created_at: :desc) }
  scope :published, -> { where(state: 'published') }
  pg_search_scope :search_by_content,
                  against: {title: 'A', excerpt: 'B', body: 'C'},
                  using: {tsearch: Rails.configuration.pg_tsearch}

  def to_param
    "#{id}-#{title.parameterize}"
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
    acting_user.signed_up?
  end

  private

  def markdown_parser(renderer)
    Redcarpet::Markdown.new(renderer, tables: true, autolink: true)
  end

  def error_raising_renderer
    @error_raising_renderer ||= markdown_parser(CustomMarkdownRenderer.new { |error| raise error })
  end

  def update_html_from_markdown
    self.body = error_raising_renderer.render(markdown_body) if markdown_body_changed?
    self.excerpt = error_raising_renderer.render(markdown_excerpt) if markdown_excerpt_changed?
  end

  def validate_markdown_fields
    [:markdown_body, :markdown_excerpt].each do |field|
      next unless public_send(:"#{field}_changed?")
      markdown_parser(CustomMarkdownRenderer.new { |error| errors.add(field, error.to_s) })
          .render(public_send(field))
    end
  end
end
