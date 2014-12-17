class ResultsMailer < ActionMailer::Base
  default from: "results@accesslint.com"

  def results_email(email, url:, results_filename:)
    @url = url
    attachments['results.csv'] = File.read(results_filename)
    mail(to: email, subject: "AccessLint Results from #{url}")
  end
end
