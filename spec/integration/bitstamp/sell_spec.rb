require "spec_helper"

describe Providers::Bitstamp, "#sell" do
  let(:result) {
    %!{"price": "1344.5", "amount": "0.1", "type": 1, "id": 12463767, "datetime": "2014-01-05 20:04:45.175960"}!
  }

  let(:provider) { described_class.new({}, client) }

  let(:client) { make_client(connection) }
  let(:connection) { mock_connection("/sell/", result) }

  it "parses open orders" do
    order = provider.sell(amount: 0.1, price: 1344.5)

    expect(order.id).to eq("12463767")

    amount = order.amount
    expect(amount.value).to be_big_decimal(0.1)
    expect(amount.currency).to eq("BTC")

    price = order.price
    expect(price.value).to be_big_decimal(1344.5)
    expect(price.currency).to eq("USD")
  end
end
