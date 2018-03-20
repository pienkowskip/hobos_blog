class AddSiteCaptions < ActiveRecord::Migration
  def caption_ids
    %w(site.title site.description site.author site.keywords)
  end

  def up
    caption_ids.each { |id| Caption.new.tap { |c| c.textid = id }.save! }
  end

  def down
    Caption.where(textid: caption_ids).destroy_all
  end
end
