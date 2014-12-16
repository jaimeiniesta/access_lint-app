class ResultsController < ApplicationController
  def index
    url = URL.new(params[:url])

    if url.valid?
      @results = Audit.new(url).execute
    else
      flash.now[:error] = url.error
      head 422
    end
  end
end

