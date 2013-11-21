require 'uri'
class HomeController < ApplicationController
  def show
    @results = []
    if params[:url]
      @url = URI::unescape(params[:url])
      rules = 'html_code_sniffer'

      if @url.match(URI.regexp)
        raw_results = AccessLint::Audit.new(@url).run(rules)
        @results = raw_results.split("\n").select{|message| message.split('|').first == 'ERROR'}
      end
    end
  end
end
