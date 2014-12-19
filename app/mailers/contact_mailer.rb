class ContactMailer < ActionMailer::Base
  default from: "from@example.com"
  default to: "cameron@thoughtbot.com"

  def customer_message(email, message)
    @message = message
    subject = "Message from #{email}"

    mail from: email, subject: subject
  end
end
