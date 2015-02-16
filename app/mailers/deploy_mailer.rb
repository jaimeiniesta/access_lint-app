class DeployMailer < ActionMailer::Base
  default from: "alerts@accesslint.com"

  def failure_message(user_email, report)
    @report = report
    mail(to: user_email, subject: "AccessLint alerts for recent deploy")
  end
end
