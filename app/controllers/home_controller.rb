require 'uri'
class HomeController < ApplicationController
  def show
    if params[:url]
      @url = URI::unescape(params[:url])
      if @url.match(URI.regexp)
        @results ||= AccessLint::Audit.new(@url).run
      end
    end
  end
end
