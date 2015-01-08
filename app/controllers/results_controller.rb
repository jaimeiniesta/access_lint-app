class ResultsController < ApplicationController
  rescue_from Runner::RunnerError, with: :runner_error

  def index
    url = URL.new(params[:url])
    if url.valid?
      runner = Runner.new(url)
      @report = ReportLoader.new(runner).report
    else
      flash.now[:error] = url.error
      @report = EmptyReport.new
    end
  end

  private

  def runner_error
    flash.now[:error] = t("runner.error")
    @report = EmptyReport.new
    render :index
  end
end
