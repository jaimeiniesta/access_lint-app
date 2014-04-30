class HomeController < ApplicationController
  before_filter :load_url

  def show
    @results = []
    @results = Audit.new(@url).execute if params[:url]
  rescue Exception => e
    notify_honeybadger(e)
    flash.now[:error] = "The url #{@url} didn't load properly."
  end

  private

  def load_url
    if params[:url]
      @url = URI.parse(params[:url])
      @url = URI::HTTP.build(host: @url.path) unless @url.kind_of? URI::HTTP
    end
  rescue
    flash.now[:error] = "The url #{@url} didn't load properly."
  end
end
