require_relative 'add_captions_migration'

class AddSearchHeaderCaption < AddCaptionsMigration
  def caption_ids
    %w(headers.search)
  end
end
