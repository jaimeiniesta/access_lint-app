class URL
  def initialize(url)
    @url = url
  end

  def valid?
    url =~ url_regex
  end

  def error
    if url.empty?
      I18n.t("url.errors.blank")
    elsif !valid?
      I18n.t("url.errors.invalid")
    end
  end

  def to_s
    raise URI::InvalidURIError unless valid?
    unless url =~ /^http+/
      @url = "http://#{url}"
    end
    URI.parse(url).to_s
  end

  private

  attr_reader :url

  def url_regex
    /^(https?:\/\/)?([^\s]+)\.([^\s]{2,6})([\/\w \.-]*)*\/?$/
  end
end
