class AddStaticSitesCaptions < ActiveRecord::Migration
  def caption_ids
    %w(static_sites.home static_sites.about static_sites.contact social.facebook.url social.youtube.url
social.instagram.url social.twitter.url social.google_plus.url social.rss.url)
  end

  def up
    caption_ids.each { |id| Caption.new.tap { |c| c.textid = id }.save! }
  end

  def down
    Caption.where(textid: caption_ids).destroy_all
  end
end
