require 'spec_helper'

describe Audit do
  describe '#execute' do
    it 'rescues JSON::ParseError and yields an Audit exception' do
      audit = Audit.new(double)
      auditor = AccessLint::Audit.new(double)

      allow(auditor).to receive(:run).and_raise(JSON::ParserError)
      expect{audit.execute}.to raise_error(Audit::ParserError)
    end
  end
end
