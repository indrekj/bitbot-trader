require "spec_helper"

describe Providers::Bitstamp, "#open_orders" do
  let(:result) {
    %![{"price": "20.10", "amount": "10.00000000", "type": 0, "id": 2826860, "datetime": "2013-04-20 12:12:14"}]!
  }

  let(:provider) { described_class.new({}, client) }

  let(:client) { make_client(connection) }
  let(:connection) { mock_connection("/open_orders/", result) }

  it "parses open orders" do
    open_orders = provider.open_orders
    expect(open_orders.size).to be(1)

    order = open_orders.first
    expect(order.id).to eq("2826860")

    amount = order.amount
    expect(amount.value).to be_big_decimal(10)
    expect(amount.currency).to eq("BTC")

    price = order.price
    expect(price.value).to be_big_decimal(20.10)
    expect(price.currency).to eq("USD")
  end
end
