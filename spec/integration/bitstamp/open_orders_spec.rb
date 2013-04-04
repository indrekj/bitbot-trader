require "spec_helper"

describe Providers::Bitstamp, "#open_orders" do
  let(:raw_bid_order) {
    {
      "id"       => 2380611,
      "datetime" => "2013-04-04 21:22:08",
      "type"     => 0,
      "price"    => "1.23000000",
      "amount"   => 43
    }
  }
  let(:provider) { described_class.new(username: "mock", password: "mock") }

  before do
    described_class::HttpRequest.stub(:post) { [raw_bid_order] }
  end

  it "parses open orders" do
    open_orders = provider.open_orders
    expect(open_orders.size).to be(1)

    order = open_orders.first
    expect(order.id).to eq(2380611)
    expect(order.amount).to eq(43)

    price = order.price
    expect(price.value).to eq(1.23)
    expect(price.currency).to eq("USD")
  end
end
