require 'spec_helper'

describe 'Auditing a page' do
  before do
    audit = double(:audit, run: 'dummy report')
    AccessLint::Audit.stub(:new).and_return(audit)
  end

  it 'returns a report' do
    visit '/'
    page.should have_content 'AccessLint'
    fill_in 'URL', with: 'http://example.com'
    click_on 'Run'
    page.should have_content 'dummy report'
  end
end
