require "rails_helper"

describe ReportLoader do
  describe "#report" do
    it "returns a report object" do
      auditor = double(:auditor, results: [])
      loader = ReportLoader.new(auditor)

      expect(loader.report).to be_a Report
    end
  end
end
