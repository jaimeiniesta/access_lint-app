class Audit
  class ParserError < Exception; end

  def initialize(url)
    @url = url
  end

  def execute
    raw_results = read_cache || run_audit
    parse_results(raw_results)
  rescue JSON::ParserError
    raise ParserError, 'Audit failed to run because the request took too long to return.'
  end

  private

  def read_cache
    Rails.cache.read(@url) || false
  end

  def run_audit
    results = AccessLint::Audit.new(@url).run
    cache_results(results)
    results
  end

  def parse_results(raw_results)
    raw_results.map do |result|
      result.delete('elements')
    end

    raw_results.group_by { |result| result['status'] }
  end

  def cache_results(results)
    Rails.cache.write(@url, results, expires_in: 5.hours)
  end
end
