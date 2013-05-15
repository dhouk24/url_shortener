
class Link < ActiveRecord::Base
  validate :url_format

  def url_format
    uri = URI("//" + self.long_url)
    uri.scheme = nil
    errors.add(:base, "URL is invalid") unless uri.host =~ (/\w+\.[a-zA-z]{2,3}/)
  end

end
