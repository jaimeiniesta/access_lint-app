class HomeController < ApplicationController
  def show
  end

  def audit
    results = AccessLint::Audit.new(params[:url]).run
    render :show, locals: { results: results }
  end
end
