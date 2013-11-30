class Audit
  attr_reader :results

  def initialize(url)
    @url = url
    @results = []
  end

  def execute
    raw_results = Rails.cache.read(@url) || AccessLint::Audit.new(@url).run
    Rails.cache.write(@url, raw_results, expires_in: 1.day)
    @results = raw_results.group_by { |result| result['status'] }
  end
end
