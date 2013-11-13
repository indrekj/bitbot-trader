require "spec_helper"

describe Providers::Bitstamp::AccountInfoParser do
  describe "#parse" do
    subject(:account) { described_class.new(data).parse }

    let(:data) {
      {
        btc_reserved: 0, fee: 0.3800, btc_available: 3.2, usd_reserved:
        6568.74, btc_balance: 3.2, usd_balance: 6568.74, usd_available: 0.00
      }
    }

    it { should be_a(Account) }
    its(:fee) { should eq(0.38) }

    context "btc wallet" do
      subject { account.wallet("BTC") }
      its(:balance) { should eq(3.2) }
    end

    context "usd wallet" do
      subject { account.wallet("USD") }
      its(:balance) { should eq(6568.74) }
    end
  end
end
