require "rails_helper"

feature "User signs up" do
  scenario "successfully" do
    visit root_path
    click_link "Sign up for a free trial of AccessLint Pro"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Sign up"

    expect(page).to have_content I18n.t(:success, scope: "flash.sign_up")
  end
end
