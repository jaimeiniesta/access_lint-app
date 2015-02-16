require "rails_helper"

describe Runner do
  describe "#results" do
    context "with stringified results" do
      it "returns JSON" do
        url = double(:url)
        phantomjs = double(:phantomjs, run: [].to_json)
        allow(PhantomJs).to receive(:new).with(url).and_return(phantomjs)
        runner = Runner.new(url)

        expect(runner.results).to eq []
      end
    end
  end

  context "with a phantomjs error message" do
    it "raises an error" do
      url = double(:url)
      phantomjs = double(:phantomjs, run: [{ errorCode: "408" }].to_json)
      allow(PhantomJs).to receive(:new).with(url).and_return(phantomjs)

      expect(Honeybadger).to receive(:notify)
      expect { Runner.new(url) }.to raise_error(Runner::RunnerError)
    end
  end
end
