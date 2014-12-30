class ResultsController < ApplicationController
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
end
