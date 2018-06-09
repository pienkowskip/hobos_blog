require_relative 'add_captions_migration'

class AddBlogHeaderCaption < AddCaptionsMigration
  def caption_ids
    %w(headers.blog)
  end
end
