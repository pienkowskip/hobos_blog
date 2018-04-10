module Front
  module BaseHelper
    def caption(textid)
      caption = Caption.find_by_textid(textid)
      if caption && !caption.body.blank?
        caption.body
      else
        block_given? ? yield : textid
      end
    end

    def nav_entry(label, path, current_page)
      content_tag(:li, class: current_page ? 'current' : nil) do
        link_to t(label), path
      end
    end
  end
end