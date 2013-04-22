require "spec_helper"

describe Providers::MtGox::AmountWriter, "#coerce" do
  subject { described_class.new("stub", coercer: nil).coerce(data) }

  let(:data) { mock }

  it "delegates to ValueWithCurrency" do
    Providers::MtGox::ValueWithCurrency.should_receive(:parse).with(data, 8)
    subject
  end
end
