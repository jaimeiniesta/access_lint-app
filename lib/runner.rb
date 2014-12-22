class Runner
  RUNNER_PATH = File.expand_path("../../vendor/axs/auditor.js", __FILE__)

  def initialize(url)
    @url = url
  end

  def execute
    raw_results
  end

  private

  attr_reader :url

  def raw_results
    `phantomjs #{RUNNER_PATH} #{@url}`
  end
end
