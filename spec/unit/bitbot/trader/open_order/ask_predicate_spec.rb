require "spec_helper"

describe OpenOrder, "ask?" do
  subject { described_class.new(options).ask? }

  context "when bid" do
    let(:options) { {bid: true} }

    it { should be(false) }
  end

  context "when ask" do
    let(:options) { {bid: false} }

    it { should be(true) }
  end
end
