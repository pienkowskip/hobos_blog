module Front
  module BaseHelper
    def caption(textid)
      caption = Caption.find_by_textid(textid)
      caption && !caption.body.blank? ? caption.body : textid
    end
  end
end