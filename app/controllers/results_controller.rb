class ResultsController < ApplicationController
  def index
    load_url

    @results = Audit.new(@url).execute || []
  rescue Exception => e
    notify_honeybadger(e)
    flash.now[:error] = "The url #{@url} didn't load properly."
    head 422
  end

  private

  def load_url
    if valid_url?
      @url = URI.parse(url_params)

      unless @url.kind_of? URI::HTTP
        @url = URI::HTTP.build(host: url.path)
      end
    else
      fail URI::BadURIError
    end
  end

  def url_params
    params.require(:url)
  end

  def valid_url?
    url_params =~ URI::regexp
  end
end

