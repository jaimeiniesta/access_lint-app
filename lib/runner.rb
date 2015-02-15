class Runner
  class RunnerError < StandardError; end

  RUNNER_PATH = File.expand_path("../../vendor/axs/auditor.js", __FILE__)

  def initialize(url)
    @url = url
  end

  def execute
    JSON.parse(raw_results, max_nesting: 200)
  rescue JSON::ParserError => e
    Honeybadger.notify(
      error_class: "JSON::ParserError",
      error_message: "JSON::ParserError: #{e.message}",
      parameters: {
        url: @url,
        body: raw_results
      }
    )
    raise RunnerError
  end

  private

  attr_reader :url

  def raw_results
    PhantomJs.new(@url).run
  end
end
