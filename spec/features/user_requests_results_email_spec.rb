require "rails_helper"

feature "User requests a results email" do
  scenario "and it is sent successfully" do
    results_path_for_example = "/results?url=example.com"
    visit results_path_for_example

    click_on "Send results to email"
    fill_in "Email", with: "user@example.com"
    click_on "Send"

    email = ActionMailer::Base.deliveries.first
    results_csv = email.attachments.first
    expect(email.to.first).to eq "user@example.com"
    expect(email.subject).to eq "AccessLint Results from example.com"
    expect(results_csv.filename).to eq "results.csv"
  end
end
