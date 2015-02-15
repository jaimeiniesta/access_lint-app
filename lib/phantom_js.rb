class PhantomJs
  RUNNER_PATH = File.expand_path("../../vendor/axs/auditor.js", __FILE__)

  def initialize(url)
    @url = url
  end

  def run
    `phantomjs #{RUNNER_PATH} #{url}`
  end

  private

  attr_reader :url
end
