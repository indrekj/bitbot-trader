require "spec_helper"

describe Providers::Bitstamp, "#account" do
  let(:result) {
    %!{"btc_reserved": "0", "fee": "0.3800", "btc_available": "3.2", "usd_reserved": "6568.74", "btc_balance": "3.2", "usd_balance": "6568.74", "usd_available": "0.00"}!
  }

  let(:provider) { described_class.new({}, client) }

  let(:client) { make_client(connection) }
  let(:connection) { mock_connection("/balance/", result) }

  it "parses account info" do
    account = provider.account

    expect(account.fee).to eq(0.38)

    usd_wallet = account.wallet("USD")
    expect(usd_wallet.balance).to eq(6568.74)

    btc_wallet = account.wallet("BTC")
    expect(btc_wallet.balance).to eq(3.2)
  end
end
