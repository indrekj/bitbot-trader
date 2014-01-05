require "spec_helper"

describe Providers::Bitstamp, "#buy" do
  let(:result) {
    %!{"price": "344.5", "amount": "0.1", "type": 0, "id": 12461441, "datetime": "2014-01-05 19:38:22.027371"}!
  }

  let(:provider) { described_class.new({}, client) }

  let(:client) { make_client(connection) }
  let(:connection) { mock_connection("/buy/", result) }

  it "parses open orders" do
    order = provider.buy(amount: 0.1, price: 344.5)

    expect(order.id).to eq("12461441")

    amount = order.amount
    expect(amount.value).to be_big_decimal(0.1)
    expect(amount.currency).to eq("BTC")

    price = order.price
    expect(price.value).to be_big_decimal(344.5)
    expect(price.currency).to eq("USD")
  end
end
