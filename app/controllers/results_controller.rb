class ResultsController < ApplicationController
  rescue_from Runner::RunnerError, with: :runner_error

  def index
    if url.valid?
      runner = Runner.new(url)
      @report = ReportLoader.new(runner).report
    else
      flash.now[:error] = url.error
      @url = params[:url]
      render_empty_report
    end
  end

  private

  def render_empty_report
    @report = EmptyReport.new
    render :index
  end

  def runner_error
    flash.now[:error] = t("runner.error")
    render_empty_report
  end

  def url
    raw_url = params[:url] || ""
    @url ||= URL.new(raw_url)
  end
end
