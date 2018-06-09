require_relative 'add_captions_migration'

class AddStaticSitesCaptions < AddCaptionsMigration
  def caption_ids
    %w(static_sites.home static_sites.about static_sites.contact social.facebook.url social.youtube.url
social.instagram.url social.twitter.url social.google_plus.url social.rss.url)
  end
end
