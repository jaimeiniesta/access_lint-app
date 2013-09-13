require 'spec_helper'

describe 'Auditing a page' do
  context 'stubbing the request' do
    let(:report) { 'dummy report' }
    before do
      audit = double(:audit)
      audit.stub(:run).with('html_codesniffer').and_return(report)
      audit.stub(:run).with('google_accessibility_developer_tools').and_return(report)
      AccessLint::Audit.stub(:new).and_return(audit)
    end

    it 'returns a report' do
      visit '/'
      page.should have_content 'AccessLint'
      fill_in 'Url', with: 'http://example.com'
      click_on 'Run'
      page.should have_content 'dummy report'

      select 'HTML CodeSniffer', from: 'Rules'
      click_on 'Run'
      page.should have_content 'dummy report'
    end
  end

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
