require "spec_helper"

describe Providers::MtGox::ValueWithCurrencyWriter, "#coerce" do
  subject { described_class.new("stub", coercer: nil).coerce(data) }

  let(:data) { mock }

  it "delegates to ValueWithCurrency" do
    Providers::MtGox::ValueWithCurrency.should_receive(:parse).with(data)
    subject
  end
end
