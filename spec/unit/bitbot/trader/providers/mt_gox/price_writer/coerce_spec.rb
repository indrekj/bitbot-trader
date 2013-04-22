require "spec_helper"

describe Providers::MtGox::PriceWriter, "#coerce" do
  subject { described_class.new("stub", coercer: nil).coerce(hash) }

  let(:hash) { stub }

  it "parses given hash" do
    described_class.should_receive(:parse).with(hash)
    subject
  end
end
