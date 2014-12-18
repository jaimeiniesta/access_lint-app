class ResultsController < ApplicationController
  def index
    @results = []
    url = URL.new(params[:url])

    if url.valid?
      @results = Audit.new(url).execute
    else
      flash.now[:error] = url.error
    end
  end
end

