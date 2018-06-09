require_relative 'add_captions_migration'

class AddStaticSitesHeaderCaptions < AddCaptionsMigration
  def caption_ids
    %w(headers.about headers.contact)
  end
end
