HoboFields::Types::EmailAddress.class_eval do
  def to_html(xmldoctype = true)
    ERB::Util.html_escape(self).html_safe
  end
end