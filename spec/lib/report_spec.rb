require "rails_helper"

describe Report do
  describe "#successes" do
    it "returns passing results" do
      code = "abc"
      results = [
        Result.new(code: code, status: "PASS", elements: [])
      ]

      report = Report.new(results)
      expect(report.passing.first.code).to eq code
    end
  end

  describe "#failing" do
    it "returns failing results" do
      code = "123"

      results = [
        Result.new(code: code, status: "FAIL", elements: [])
      ]

      report = Report.new(results)
      expect(report.failing.first.code).to eq code
    end
  end

  describe "#not_applicable" do
    it "returns failing results" do
      code = "123"

      results = [
        Result.new(code: code, status: "NA", elements: nil)
      ]

      report = Report.new(results)
      expect(report.not_applicable.first.code).to eq code
    end
  end
end
