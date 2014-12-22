class ResultsController < ApplicationController
  def index
    @results = []
    url = URL.new(params[:url])

    if url.valid?
      runner = Runner.new(url)
      @report = ReportLoader.new(runner).report
    else
      flash.now[:error] = url.error
    end
  end
end

