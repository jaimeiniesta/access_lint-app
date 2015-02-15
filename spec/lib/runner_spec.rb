require "rails_helper"

describe Runner do
  describe "#execute" do
    context "with stringified results" do
      it "returns JSON" do
        url = double(:url)
        runner = Runner.new(url)
        phantomjs = double(:phantomjs, run: [].to_json)

        allow(PhantomJs).to receive(:new).with(url).and_return(phantomjs)

        result = runner.execute
        expect(result).to eq []
      end
    end
  end

  context "with a phantomjs error message" do
    it "raises an error" do
      url = double(:url)
      runner = Runner.new(url)
      phantomjs = double(:phantomjs, run: "error")

      allow(PhantomJs).to receive(:new).with(url).and_return(phantomjs)

      expect(Honeybadger).to receive(:notify)
      expect { runner.execute }.to raise_error(Runner::RunnerError)
    end
  end
end
