class HomeController < ApplicationController
  def show
    @results = []

    if params[:url]
      @url = URI.parse(params[:url])
      @results = Audit.new(@url).execute
    end
  rescue Audit::ParserError => e
    flash[:error] = e.message
  end
end
