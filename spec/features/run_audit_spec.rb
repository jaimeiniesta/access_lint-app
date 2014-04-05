require 'spec_helper'

describe 'Auditing a page' do
  context 'with a full audit' do
    it 'does not have javascript errors' do
      visit '/'
      fill_in 'Url', with: 'http://google.com'
      click_on 'Run'
      page.should_not have_content 'Audit Results'

      fill_in 'Url', with: 'http://html5doctor.com'
      click_on 'Run'
      page.should_not have_content 'TypeError'
    end
  end
end
