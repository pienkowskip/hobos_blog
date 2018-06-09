require_relative 'add_captions_migration'

class AddGoogleAnalyticsCaption < AddCaptionsMigration
  def caption_ids
    %w(site.ga_tracking_id)
  end
end
