require "rails_helper"

describe Result do
  describe "#elements" do
    it "returns an array of html strings" do
      code = "AX_ARIA_01"
      status = double(:status)
      elements = []

      result = Result.new(code: code, status: status, elements: elements)
      expect(result.elements).to be_an Array
    end
  end

  describe "#title" do
    it "returns an I18n string" do
      code = "AX_ARIA_01"
      status = double(:status)
      elements = []

      result = Result.new(code: code, status: status, elements: elements)
      expect(
        result.title
      ).to(
        eq "Elements with ARIA roles must use a valid, non-abstract ARIA role"
      )
    end
  end

  describe "#passing?" do
    context "with a passing status" do
      it "returns true" do
        code = "AX_ARIA_01"
        status = "PASS"
        elements = []

        result = Result.new(code: code, status: status, elements: elements)
        expect(
          result.passing?
        ).to eq true
      end
    end
  end

  describe "#failing?" do
    context "with a failing status" do
      it "returns true" do
        code = "AX_ARIA_01"
        status = "FAIL"
        elements = []

        result = Result.new(code: code, status: status, elements: elements)
        expect(
          result.failing?
        ).to eq true
      end
    end
  end

  describe "#not_applicable?" do
    context "with a n/a status" do
      it "returns true" do
        code = "AX_ARIA_01"
        status = "NA"
        elements = []

        result = Result.new(code: code, status: status, elements: elements)
        expect(
          result.not_applicable?
        ).to eq true
      end
    end
  end
end
