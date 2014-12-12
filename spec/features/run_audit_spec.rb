require 'spec_helper'

describe 'Auditing a page' do
  context 'with a full audit' do
    it 'does not have javascript errors' do
      visit '/'
      fill_in 'URL to Test', with: 'http://google.com'
      click_on 'Run'
      expect(page).to have_content 'Passing'
    end
  end
end
