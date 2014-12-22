class Report
  attr_reader :report, :results

  def initialize(results)
    @results = results
  end

  def passing
    results.select(&:passing?)
  end

  def failing
    results.select(&:failing?)
  end

  def not_applicable
    results.select(&:not_applicable?)
  end
end
