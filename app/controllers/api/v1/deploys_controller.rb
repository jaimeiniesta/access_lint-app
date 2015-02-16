class Api::V1::DeploysController < ActionController::Base
  protect_from_forgery with: :exception

  def create
    runner = Runner.new(url_param)
    report = ReportLoader.new(runner).report

    if report.failing.any?
      DeployMailer.failure_message(params[:user], report).deliver
    end

    head :ok
  end

  private

  def url_param
    params.require(:url)
  end
end
