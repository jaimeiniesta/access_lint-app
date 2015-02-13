require "rails_helper"

describe "Auditing a page" do
  context "with a full audit" do
    it "shows results in a disclosable widget", :js do
      visit root_path

      expect(page.driver.error_messages).to be_empty

      within("fieldset") do
        fill_in "URL to Test", with: "google.com"
        click_on "Run"
      end

      expect(page).to have_content "Failing"
      expect(page).not_to have_css "pre"

      page.first("[role='tab']").click
      expect(page).to have_css "pre"
    end
  end

  context "when the audit fails" do
    it "displays an error message" do
      visit root_path

      within("fieldset") do
        fill_in "URL to Test", with: "invalid_url"
        click_on "Run"
      end

      expect(page).to have_content I18n.t("url.errors.invalid")
    end
  end
end
