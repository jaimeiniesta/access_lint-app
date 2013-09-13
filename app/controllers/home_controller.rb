require 'uri'
class HomeController < ApplicationController
  def show
    if params[:url]
      @url = URI::unescape(params[:url])
      @rules = URI::unescape(params[:rules])
      
      if @url.match(URI.regexp)
        @results ||= AccessLint::Audit.new(@url).run(@rules)
      end
    end
  end
end
