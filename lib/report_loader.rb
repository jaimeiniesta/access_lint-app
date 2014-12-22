class ReportLoader
  attr_reader :report

  def initialize(runner)
    @runner = runner
  end

  def report
    Report.new(results)
  end

  private

  attr_reader :runner

  def results
    results_hash.map do |result_hash|
      Result.new(result_hash)
    end
  end

  def results_hash
    JSON.parse(runner.execute, max_nesting: 200)
  end
end
