class HomeController < ApplicationController
  def show
    @results = []
    if params[:url]
      @url = URI::unescape(params[:url])

      if @url.match(URI.regexp)
        raw_results = AccessLint::Audit.new(@url).run
        @results = raw_results.group_by { |result| result['status'] }
      end
    end
  rescue JSON::ParserError
    @results = []
    flash[:error] = "Audit failed to run because the request took too long to return."
  end
end
