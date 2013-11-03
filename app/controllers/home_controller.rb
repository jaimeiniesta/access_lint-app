require 'uri'
class HomeController < ApplicationController
  def show
    if params[:url]
      @url = URI::unescape(params[:url])
      rules = 'google_accessibility_developer_tools'

      if @url.match(URI.regexp)
        @results ||= AccessLint::Audit.new(@url).run(rules)
      end
    end
  end
end
