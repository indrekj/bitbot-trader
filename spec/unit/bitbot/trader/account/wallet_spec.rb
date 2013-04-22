require "spec_helper"

describe Account, "#wallet" do
  subject { described_class.new(wallets: wallets).wallet(currency) }

  let(:wallets) {
    [
      {currency: "EUR", value: 123},
      {currency: "BTC", value: 43}
    ]
  }

  context "when EUR" do
    let(:currency) { "EUR" }

    it { should be_a(Wallet) }
    its(:balance) { should eq(123) }
  end

  context "when BTC" do
    let(:currency) { "BTC" }

    it { should be_a(Wallet) }
    its(:balance) { should eq(43) }
  end
end
