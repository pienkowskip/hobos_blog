module Front
  module BaseHelper
    def caption(textid)
      caption = Caption.find_by_textid(textid)
      if caption && !caption.body.blank?
        block_given? ? yield(caption.body) : caption.body
      else
        textid
      end
    end

    def nav_entry(label, path, current_page_options = {})
      html_class = (controller_path == current_page_options[:controller] || current_page_options[:controller].nil?) &&
          (action_name == current_page_options[:action] || current_page_options[:action].nil?) &&
          !current_page_options.empty? ?
                       'current' : nil
      content_tag(:li, class: html_class) do
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