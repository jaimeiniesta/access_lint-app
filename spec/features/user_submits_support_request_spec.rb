require "rails_helper"

describe "Customer sends a support request" do
  before do
    @email = "customer@example.com"
    @to_email = "cameron@thoughtbot.com"
    @message = "Hey very good idea, talk to me for some other business"
  end

  it "submits a message" do
    visit root_path

    click_on "Contact"

    fill_in "email", :with => @email
    fill_in "message", :with => @message

    click_on "Send"

    open_email @to_email
    expect(current_email).to have_content @message
  end
end
