require 'spec_helper'

describe 'Auditing a page' do
  context 'stubbing the request' do
    let(:report) { "ERROR|dummy report\nWARNING|irrelevant" }
    before do
      audit = double(:audit)
      audit.stub(:run).with('html_code_sniffer').and_return(report)
      AccessLint::Audit.stub(:new).and_return(audit)
    end

    it 'returns a report' do
      visit '/'
      page.should have_content 'AccessLint'
      fill_in 'Url', with: 'http://example.com'
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
