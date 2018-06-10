class CustomMarkdownRenderer < Redcarpet::Render::XHTML
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  attr_reader :error_callback

  def initialize(*args, &block)
    @error_callback = block
    super(*args)
  end

  def image(link, title, alt_text)
    title = image_attribute_parse(title)
    alt_text = image_attribute_parse(alt_text)
    alt_text = title unless alt_text
    asset_id = begin
      Integer(link)
    rescue ArgumentError
      return content_tag(
          :figure,
          link_to(image_tag(link, alt: alt_text, title: title), link) +
              (title ? "\n" + content_tag(:figcaption, title) : '').html_safe)
    end
    begin
      asset = Asset.find(asset_id)
      asset = asset.asset
      alt_text = asset.original_filename unless alt_text
      image_text = if asset.exists?(:medium)
                     image_tag(asset.url(:medium), alt: alt_text, title: title)
                   else
                     ERB::Util::html_escape(asset.original_filename)
                   end
      large_image = if asset.exists?(:large)
                      asset.url(:large)
                    elsif asset.exists?(:medium)
                      asset.url(:medium)
                    else
                      nil
                    end
      content_tag(
          :figure,
          link_to(image_text, asset.url, 'data-src': large_image) +
              (title ? "\n" + content_tag(:figcaption, title) : '').html_safe)
    rescue => error
      error_callback.call(error) if error_callback
      ERB::Util::html_escape('![%s](%s%s)' % [alt_text, link, title ? ' "' + title + '"' : nil])
    end
  end

  private

  def image_attribute_parse(value)
    if value.respond_to?(:blank?) && value.blank?
      nil
    else
      value = value.strip if value.respond_to?(:strip)
      value = value.html_safe if value.respond_to?(:html_safe)
      value
    end
  end
end
