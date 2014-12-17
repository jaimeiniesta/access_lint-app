class ResultsEmailsController < ApplicationController
  def new; end

  def create
    ResultsMailer.results_email(request_email_params[:email]).deliver

    redirect_to results_path
  end

  private

  def request_email_params
    params.require(:results_email).permit(:email)
  end
end
