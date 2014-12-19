require "rails_helper"

describe ContactMailer do
  before do
    @email = "customer@example.com"
    @message = "Hey very good idea, talk to me for some other business"
    @subject = "Message from #{@email}"
  end

  it "composes a subject with the customer email" do
    mailer = ContactMailer.customer_message(@email, @message)

    expect(mailer.subject).to eq @subject
  end
end
