class Runner
  class RunnerError < StandardError; end

  attr_reader :results

  def initialize(url)
    @url = url
    execute_audit
    load_results

    if has_error?
      report_error
      raise RunnerError
    end
  end

  private

  attr_reader :url, :response

  def execute_audit
    @response ||= PhantomJs.new(@url).run
  end

  def load_results
    @results = JSON.parse(@response, max_nesting: 200)
  end

  def has_error?
    @results.any? { |r| r.has_key?("errorCode") }
  end

  def error_code
    @results.first["errorCode"]
  end

  def error_status
    @results.first["errorStatus"]
  end

  def report_error
    Honeybadger.notify(
      error_class: "RunnerError: #{error_code}",
      error_message: error_status,
      parameters: {
        url: @url,
        body: @response
      }
    )
  end
end
