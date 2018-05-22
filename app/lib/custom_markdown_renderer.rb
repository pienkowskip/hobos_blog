class CustomMarkdownRenderer < Redcarpet::Render::XHTML
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  attr_reader :error_callback

  def initialize(*args, &block)
    @error_callback = block
    super(*args)
  end

  def image(link, title, alt_text)
    asset_id = begin
      Integer(link)
    rescue ArgumentError
      return content_tag(
          :figure,
          link_to(image_tag(link, alt: alt_text.to_s, title: title.to_s), link) +
              (title ? "\n" + content_tag(:figcaption, title) : '').html_safe)
    end
    begin
      asset = Asset.find(asset_id)
      asset = asset.asset
      image_text = if asset.exists?(:medium)
                     image_tag(asset.url(:medium), alt: alt_text, title: title)
                   else
                     ERB::Util::html_escape(asset.original_filename)
                   end
      content_tag(
          :figure,
          link_to(image_text, asset.url) +
              (title ? "\n" + content_tag(:figcaption, title) : '').html_safe)
    rescue => error
      error_callback.call(error) if error_callback
      ERB::Util::html_escape('![%s](%s%s)' % [alt_text, link, title ? ' "' + title + '"' : nil])
    end
  end
end
