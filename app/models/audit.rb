class Audit
  attr_reader :results

  def initialize(url)
    @url = url
    @results = []
  end

  def execute
    raw_results = AccessLint::Audit.new(@url).run
    @results = raw_results.group_by { |result| result['status'] }
  end
end
