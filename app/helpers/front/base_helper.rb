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

    def gravatar_hash(email)
      Digest::MD5.hexdigest(email.strip.downcase)
    end

    def gravatar_avatar_url(email)
      'https://www.gravatar.com/avatar/' + gravatar_hash(email) + '?' + {s: 50, d: 'blank'}.to_query
    end

    def gravatar_jsonp_url(email, callback)
      'https://www.gravatar.com/' + gravatar_hash(email) + '.json?' + {callback: callback}.to_query
    end
  end
end