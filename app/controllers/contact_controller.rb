class ContactController < ApplicationController
  before_action :validate_email_presence, only: :create

  def index
  end

  def create
    ContactMailer.customer_message(params[:email], params[:message]).deliver

    flash[:notice] = "Thank you for sending a message we'll get back to you shortly"

    redirect_to root_path
  end

  def validate_email_presence
    params.require(:email)
    params.require(:message)

  rescue
    flash.now[:error] = "Please make sure to fill in your email and message"

    render :index
  end
end
