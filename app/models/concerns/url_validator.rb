class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    uri = URI.parse(value)
    return if [nil, 'http', 'https'].include?(uri.scheme) && uri.host
    record.errors.add(attribute, :invalid)
  rescue URI::InvalidURIError
    record.errors.add(attribute, :invalid)
  end
end