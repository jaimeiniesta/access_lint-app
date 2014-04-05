class Audit
  class ParserError < Exception; end

  def initialize(url)
    @url = url
  end

  def execute
    if results = read_cache
      return results
    else
      raw_results = run_audit
      parse_results(raw_results)
    end
  rescue JSON::ParserError
    raise ParserError, 'Audit failed to run because the request took too long to return.'
  end

  private

  def read_cache
    Rails.cache.read(@url.to_s) || false
  end

  def run_audit
    AccessLint::Audit.new(@url).run
  end

  def parse_results(raw_results)
    raw_results.map do |result|
      result.delete('elements')
    end

    cache_results(raw_results)
    raw_results
  end

  def cache_results(results)
    Rails.cache.write(@url.to_s, results, expires_in: 5.hours)
  end
end
