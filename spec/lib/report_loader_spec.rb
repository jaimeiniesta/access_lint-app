require "rails_helper"

describe ReportLoader do
  describe "#report" do
    it "returns a report object" do
      results = [].to_json
      auditor = double(:auditor, execute: results)
      loader = ReportLoader.new(auditor)
      expect(loader.report).to be_a Report
    end
  end
end
