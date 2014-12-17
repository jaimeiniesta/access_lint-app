require "rails_helper"

describe ResultsMailer do
  describe "#results_email" do
    it "sends an email with results attached" do
      allow(File).to receive(:read).and_return("example file")

      ResultsMailer.results_email(
        "test@example.com",
        url: "example.com",
        results_filename: "example_com.csv"
      ).deliver

      email = ActionMailer::Base.deliveries.first
      results_csv = email.attachments.first
      expect(email.to.first).to eq "test@example.com"
      expect(email.from.first).to eq "results@accesslint.com"
      expect(email.subject).to eq "AccessLint Results from example.com"
      expect(email.body.encoded).to include "example.com"
      expect(results_csv.filename).to eq "results.csv"
    end
  end
end
