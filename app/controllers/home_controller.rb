class HomeController < ApplicationController
  def show
    @results = []
    if params[:url]
      @url = URI::unescape(params[:url])
      @results = Audit.new(@url).execute if @url.match(URI.regexp)
    end
  rescue JSON::ParserError
    flash[:error] = "Audit failed to run because the request took too long to return."
  end
end
