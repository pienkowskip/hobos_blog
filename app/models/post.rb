class Post < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title            :string, :required, null: false
    state            :string, :required, null: false, default: 'draft'
    published_at     :datetime
    body             :text, null: false
    excerpt          :text
    markdown_body    :text, :required, null: false
    markdown_excerpt :text
    timestamps
  end
  attr_accessible :title, :published_at, :author, :author_id, :category, :category_id, :body, :markdown_body, :excerpt, :markdown_excerpt, :state

  belongs_to :author, class_name: 'User', inverse_of: :posts
  belongs_to :category, inverse_of: :posts

  validate :validate_markdown_fields

  before_save :update_html_from_markdown

  default_scope -> { order(created_at: :desc) }

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

  def error_raising_renderer
    @error_raising_renderer ||= Redcarpet::Markdown.new(CustomMarkdownRenderer.new { |error| raise error })
  end

  def update_html_from_markdown
    self.body = error_raising_renderer.render(markdown_body) if markdown_body_changed?
    self.excerpt = error_raising_renderer.render(markdown_excerpt) if markdown_excerpt_changed?
  end

  def validate_markdown_fields
    [:markdown_body, :markdown_excerpt].each do |field|
      next unless public_send(:"#{field}_changed?")
      renderer = CustomMarkdownRenderer.new { |error| errors.add(field, error.to_s) }
      Redcarpet::Markdown.new(renderer).render(public_send(field))
    end
  end
end
