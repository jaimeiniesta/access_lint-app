require "rails_helper"

describe DeployMailer do
  it "sends a message" do
    user_email = "bobby@example.com"
    mailer = DeployMailer.failure_message(
      user_email,
      double(:report, failing: [])
    )
    expect(mailer.to).to eq [user_email]
  end
end
