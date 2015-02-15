require "rails_helper"

describe PhantomJs do
  it "shells out to phantomjs" do
    phantomjs = PhantomJs.new("http://example.com")
    allow(phantomjs).to receive(:`)

    phantomjs.run

    expect(phantomjs).to have_received(:`).with(/phantomjs/)
  end
end
