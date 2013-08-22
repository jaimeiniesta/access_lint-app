require 'uri'
class HomeController < ApplicationController
  def show
    @url = params[:url]
    if @url && @url.match(URI.regexp)
      @results ||= AccessLint::Audit.new(@url).run
    end
  end
end
