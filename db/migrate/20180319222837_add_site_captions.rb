require_relative 'add_captions_migration'

class AddSiteCaptions < AddCaptionsMigration
  def caption_ids
    %w(site.title site.description site.author site.keywords)
  end
end
