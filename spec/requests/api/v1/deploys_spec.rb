require "rails_helper"

describe "Deploy Hook API" do
  context "when the audit has no failures" do
    it "does not send an email" do
      url = "http://example.com"
      user_email = "bobby@example.com"
      phantomjs = double :phantomjs, run: [].to_json
      allow(PhantomJs).to receive(:new).with(url).and_return(phantomjs)

      post "/api/v1/deploys", url: url, user: user_email

      expect(ActionMailer::Base.deliveries).to be_empty
    end
  end

  context "when the audit has failures" do
    it "sends an email" do
      url = "http://example.com"
      user_email = "bobby@example.com"
      error = { status: "FAIL" }
      phantomjs = double :phantomjs, run: [error].to_json
      allow(PhantomJs).to receive(:new).with(url).and_return(phantomjs)

      post "/api/v1/deploys", url: url, user: user_email

      expect(ActionMailer::Base.deliveries).not_to be_empty
    end
  end
end
