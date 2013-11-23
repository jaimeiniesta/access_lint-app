require 'uri'
class HomeController < ApplicationController
  rescue_from Timeout::Error, :with => :handle_timeout

  def show
    @results = []
    if params[:url]
      @url = URI::unescape(params[:url])
      rules = 'html_code_sniffer'

      if @url.match(URI.regexp)
        raw_results = AccessLint::Audit.new(@url).run(rules)
        raw_results = raw_results.split("\n").select{|message| message.split('|').first == 'ERROR'}
        @results = raw_results.collect { |result| result.gsub('ERROR|', '').split('|') }
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
