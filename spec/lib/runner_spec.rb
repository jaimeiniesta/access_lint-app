require "rails_helper"

describe Runner do
  describe "#execute" do
    it "returns JSON" do
      url = double(:url)
      runner = Runner.new(url)
      allow(runner).to receive(:`).and_return([].to_json)

      result = runner.execute
      expect(JSON.parse(result)).to eq []
    end
  end
end
