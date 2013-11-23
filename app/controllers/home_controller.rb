require 'uri'
class HomeController < ApplicationController
  rescue_from Timeout::Error, :with => :handle_timeout

  def show
    @results = []
    if params[:url]
      @url = URI::unescape(params[:url])

      if @url.match(URI.regexp)
        raw_results = AccessLint::Audit.new(@url).run
        @results = raw_results.group_by { |result| result['status'] }
        flash[:notice] = "Audit complete."
      end
    end
  end

  private

  def handle_timeout
    flash[:error] = e.message
    @results = []
  end
end
