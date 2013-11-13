require "spec_helper"

describe Wallet do
  describe ".build" do
    it "builds a new wallet" do
      wallet = described_class.build("USD", 1.2)
      expect(wallet.balance).to eq(1.2)
      expect(wallet.currency).to eq("USD")
    end
  end
end
