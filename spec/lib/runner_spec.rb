require "rails_helper"

describe Runner do
  describe "#execute" do
    context "with stringified results" do
      it "returns JSON" do
        url = double(:url)
        runner = Runner.new(url)
        allow(runner).to receive(:`).and_return([].to_json)

        result = runner.execute
        expect(result).to eq []
      end
    end
  end

  context "with a phantomjs error message" do
    it "raises an error" do
      url = double(:url)
      runner = Runner.new(url)
      allow(runner).to receive(:`).and_return("Could not parse url")

      expect(Honeybadger).to receive(:notify)
      expect { runner.execute }.to raise_error(Runner::RunnerError)
    end
  end
end
